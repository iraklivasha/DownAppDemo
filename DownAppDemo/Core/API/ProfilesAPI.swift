//
//  ProfilesAPI.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import Foundation

protocol ProfilesAPIProtocol: AnyObject {
    func fetch() -> APIRequest<[Profile]>
}

class ProfilesAPI: BaseAPI, ProfilesAPIProtocol {
    func fetch() -> APIRequest<[Profile]> {
        let endpoint = Router.profile.fetch(request: BaseRequest())
        return super.request(endpoint: endpoint)
    }
}
