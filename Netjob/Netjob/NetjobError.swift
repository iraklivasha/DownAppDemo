//
//  NetjobError.swift
//  Netjob
//
//  Created by Irakli Vashakidze on 01/06/2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation

public enum NetjobError: Error {
    case sessionFailed(error: URLError)
    case decodingFailed
    case other(Error)
}
