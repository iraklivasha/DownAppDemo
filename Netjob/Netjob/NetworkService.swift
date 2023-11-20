//
//  NetworkService.swift
//  Netjob
//
//  Created by Irakli Vashakidze on 01/06/2020.
//  Copyright © 2020. All rights reserved.
//

import Combine

extension Dictionary {
    var data: Data {
        let data = try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)
        return data ?? Data()
    }
}

@available(iOS 13.0, *)
public protocol Network {
    @discardableResult func request(endpoint: Endpoint) -> NetworkRequest
}

@available(iOS 13.0, *)
class NetworkService: NSObject, Network {
    
    static let shared = NetworkService()
    private override init() {}
    
    @available(iOS 13.0, *)
    @discardableResult func request(endpoint: Endpoint) -> NetworkRequest {

        // declaring the default headers that are common with all endpoints
        var request = URLRequest(url: urlWith(url: endpoint.url,
                                              query: (endpoint.method == .get || endpoint.method == .delete)
                                                ?
                                              endpoint.parameters as? [String: Any]
                                                :
                                                endpoint.urlParameters))
        request.httpMethod = endpoint.method.name
        request.allHTTPHeaderFields = endpoint.headers
        request.setValue(endpoint.requestContentType, forHTTPHeaderField: "Content-Type")
        request.httpShouldHandleCookies = false
        request.cachePolicy = endpoint.cachePolicy
        
        if endpoint.method == .post || endpoint.method == .patch {
            
            if (endpoint.requestContentType == "application/x-www-form-urlencoded") {
                
                var str = ""
                let params = (endpoint.parameters as? [String: Any] ?? [:])
                for (i, kv) in params.enumerated() {
                    if let v = kv.value as? String {
                        str.append("\(kv.key)=\(v)")
                        if i < params.count - 1 {
                            str.append("&")
                        }
                    }
                }
                
                request.httpBody = str.data(using: .utf8)
                request.setValue("\(request.httpBody?.count ?? 0)", forHTTPHeaderField: "Content-Length")
            } else {
                request.encodeParameters(parameters: endpoint.parameters ?? [:])
            }
        }
        
        let publisher = URLSession.shared
            .dataTaskPublisher(for: request)
            .eraseToAnyPublisher()
        
        return NetworkRequest(publisher: publisher)
    }
    
    func urlWith(url: String, query: [String: Any]?) -> URL {
        // make sure the base url is valid
        guard let baseUrl = URL(string: url) else {
            fatalError("The BASE URL provided is not a valid url: \(url)")
        }
        // if there are any query items
        guard let query = query else { return baseUrl }
        
        // create the url query
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        components?.queryItems = query.map { element in URLQueryItem(name: element.key, value: String(describing: element.value)) }
        
        guard let url = components?.url else { return baseUrl }
        return url
    }
}
