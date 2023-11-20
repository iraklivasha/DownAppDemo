//
//  DownEndpoint.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//


import Foundation
import Netjob

private let baseURL = "https://raw.githubusercontent.com/"

protocol DownEndpoint: Endpoint {
    
    /// The last path component to the endpoint. will be appended to the base url in the service
    var path: String { get }
    
    /// The encoded parameters
    var parameters: Any? { get }
    
    /// The HTTP headers to be appended in the request, default is nil
    var additionalHeaders: [String: String]? { get }
    
    /// Http method as specified by the server
    var method: HTTPMethod { get }
    
    /// How long (in seconds) a task should wait for additional data to arrive. The timer is reset whenever new data arrives.
    var timeout: TimeInterval { get }
    
    /// Caching policy for the endpoint
    var cachePolicy: URLRequest.CachePolicy { get }
    
    var mockPath: String? { get }
}

extension DownEndpoint {
    
    var url: String {
        return baseURL + path
    }
    
    var additionalHeaders: [String: String]? {
        return nil
    }
    
    var headers: [String: String]? {
        var headers: [String: String] = [:]
        headers["Authorization"] = "Bearer \("some-token")"
        guard let additional = additionalHeaders else { return headers }
        headers.merge(additional) { (headersValue, additionalValue) -> String in
            return additionalValue
        }
        return headers
    }
    
    var timeout: TimeInterval {
        return 30
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalCacheData
    }
    
    var parameters: Any? {
        return nil
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var decoder: JSONDecoder {
        Coding.decoder
    }
    
    func request() -> NetworkRequest {
        return self.request(endpoint: self)
    }
    
    var urlParameters: [String : String]? {
        return nil
    }
    
    var mockPath: String? {
        return nil
    }
    
    var network: Network {
        return Netjob.shared.defaultNetworkService
    }
}

class AnyCodable: Codable {}
