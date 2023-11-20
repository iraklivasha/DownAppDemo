//
//  MatchType.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import UIKit

enum MatchType: String {
    case down
    case date
    
    var title: String {
        self.rawValue.uppercased()
    }
    
    var color: UIColor {
        switch self {
        case .down: return .systemRed
        case .date: return .systemGreen
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .date: return UIImage(named: "ic-visitors")
        case .down: return UIImage(named: "ic-snapmatch")
        }
    }
}

