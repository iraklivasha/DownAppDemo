//
//  Dictionary+Ext.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import Foundation

extension Dictionary {
   
    var data: Data {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)
            return data
        } catch let e {
            debugPrint("Dictionary.data:Error: \(e)")
        }
        
        return Data()
    }

    /// EZSE: Union of self and the input dictionaries.
    public func union(_ dictionaries: Dictionary...) -> Dictionary {
        var result = self
        dictionaries.forEach { (dictionary) -> Void in
            dictionary.forEach { (arg) -> Void in
                
                let (key, value) = arg
                result[key] = value
            }
        }
        return result
    }
}
