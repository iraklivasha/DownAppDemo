//
//  Router+Profiles.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import Netjob

extension Router {
    
    enum profile: DownEndpoint {
        var path: String {
            switch self {
            case .fetch:
                return "/downapp/sample/main/sample.json"
            }
        }
        
        var method: HTTPMethod { return .get }
        case fetch(request: BaseRequest)
    }
}
