//
//  Coding.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import Foundation
import Netjob

struct Coding {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = Netjob.shared.keyDecodingStrategy
        decoder.dateDecodingStrategy = Netjob.shared.dateDecodingStrategy
        decoder.nonConformingFloatDecodingStrategy = Netjob.shared.nonConformingFloatDecodingStrategy
        return decoder
    }
    
    
    static var encoder: JSONEncoder {
        let decoder = JSONEncoder()
        decoder.keyEncodingStrategy = Netjob.shared.keyEncodingStrategy
        decoder.dateEncodingStrategy = Netjob.shared.dateEncodingStrategy
        decoder.nonConformingFloatEncodingStrategy = Netjob.shared.nonConformingFloatEncodingStrategy
        return decoder
    }
}
