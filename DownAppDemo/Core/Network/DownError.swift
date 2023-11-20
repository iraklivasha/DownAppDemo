//
//  DownError.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import Foundation

enum DownError: Error {
    case sessionFailed(error: URLError)
    case decodingFailed
    case invalidURL
    case other(Error)
}
