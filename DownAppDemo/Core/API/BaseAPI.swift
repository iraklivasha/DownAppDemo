//
//  BaseAPI.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import Foundation
import Netjob
import Combine

struct APIRequest<T: Codable> {
    public let task: AnyPublisher<T, DownError>
    public init(task: AnyPublisher<T, DownError>) {
        self.task = task
    }
}

class BaseAPI {
    
    func request<T: Codable>(endpoint: any DownEndpoint) -> APIRequest<T> {
        let publisher = endpoint
                        .request(endpoint: endpoint)
                        .publisher
                        .receive(on: RunLoop.main)
                        .map(\.data)
                        .decode(type: T.self, decoder: Coding.decoder)
                        .mapError({ error in
                                switch error {
                                case is Swift.DecodingError:
                                  return DownError.decodingFailed
                                default:
                                    return DownError.other(error)
                                }
                            
                            // Here we can be more concrete on errors, depending on what kind of errors should the app handle
                              })
                        .eraseToAnyPublisher()
        
        return APIRequest(task: publisher)
    }
}
