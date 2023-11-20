//
//  Profile.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import Foundation

struct Profile: Codable {
    private(set) var name: String
    private(set) var userId: Int
    private(set) var age: Int
    private(set) var loc: String
    private(set) var aboutMe: String
    private(set) var profilePicUrl: String
}
