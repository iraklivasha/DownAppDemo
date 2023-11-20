//
//  Data+String.swift
//  Netjob
//
//  Created by Irakli Vashakidze on 01/06/2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation

extension Data {
    
    func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }
}
