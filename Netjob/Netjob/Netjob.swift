//
//  Netjob.swift
//  Netjob
//
//  Created by Irakli Vashakidze on 01/06/2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation

public class Netjob {
    public static var shared = Netjob()
    private init() {}
    
    public var activateSSlPinning: Bool = false
    public var keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
    public var dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601
    public var keyEncodingStrategy = JSONEncoder.KeyEncodingStrategy.convertToSnakeCase
    public var dateEncodingStrategy = JSONEncoder.DateEncodingStrategy.iso8601
    public var nonConformingFloatDecodingStrategy = JSONDecoder.NonConformingFloatDecodingStrategy.convertFromString(
                                                                positiveInfinity: "inf",
                                                                negativeInfinity: "-inf",
                                                                nan: "nan")
    public var nonConformingFloatEncodingStrategy = JSONEncoder.NonConformingFloatEncodingStrategy.convertToString(
                                                                positiveInfinity: "inf",
                                                                negativeInfinity: "-inf",
                                                                nan: "nan")
    
    public var defaultNetworkService: Network = NetworkService.shared
}
