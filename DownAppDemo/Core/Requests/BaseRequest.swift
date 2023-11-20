//
//  BaseRequest.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import Foundation

// It's
class BaseRequest {
    
    var params: Any? {
        return [String:Any]()
    }
    
    var dictionaryParams: [String: Any]? {
        return self.params as? [String: Any]
    }
}
