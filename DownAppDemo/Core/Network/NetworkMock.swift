//
//  NetworkMock.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import Foundation
import Netjob
import Combine

class NetworkMock: Network {
    
    private var jsonObject: Data?
    private lazy var stringResponse = ""
    
    init(mockURL: URL) {
        if let data = try? Data(contentsOf: mockURL) {
            self.jsonObject = data
        }
    }
    
    init(file: String, ext: String = "json", fromBundle bundle: Bundle = Bundle.main) {
        if let url = bundle.url(forResource: file, withExtension: ext) {
           self.jsonObject = try? Data(contentsOf: url)
        }
    }
    
    init(stringResponse: String) {
        self.stringResponse = stringResponse
    }
    
    @discardableResult func request(endpoint: Endpoint) -> NetworkRequest {
        return NetworkRequest(publisher: apiResponse())
    }
    
    func apiResponse() -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLError> {
        let response = HTTPURLResponse()
        return Just((data: self.jsonObject ?? Data(), response: response))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}
