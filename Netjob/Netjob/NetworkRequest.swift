//
//  NetworkRequest.swift
//  Netjob
//
//  Created by Irakli Vashakidze on 6/4/20.
//  Copyright © 2020. All rights reserved.
//

import Combine
import Foundation

public struct NetworkRequest {
    public let publisher: AnyPublisher<URLSession.DataTaskPublisher.Output, URLError>
    public init(publisher: AnyPublisher<URLSession.DataTaskPublisher.Output, URLError>) {
        self.publisher = publisher
    }
}
