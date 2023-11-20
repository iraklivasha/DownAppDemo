//
//  MainTabbarController.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 19.11.23.
//

import Foundation
import UIKit
import SnapKit

class DownTabbar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 80
        return sizeThatFits
    }
}

enum TabType: String {
    case down
    case snapmatch
    case visitors
    case chats
    
    var screen: UIViewController {
        switch self {
        case .down: return DownController()
        case .snapmatch: return SnapMatchController()
        case .visitors: return VisitorsController()
        case .chats: return ChatsController()
        }
    }
    
    var navigationScreen: UINavigationController {
        let tab = UINavigationController(rootViewController: self.screen)
        tab.tabBarItem = self.tab
        return tab
    }
    
    var title: String {
        switch self {
        case .down: return "DOWN"
        case .snapmatch: return "Snap Match"
        case .visitors: return "Visitors"
        case .chats: return "Chats"
        }
    }
    
    var icon: UIImage? {
        return UIImage(named: "ic-\(self.rawValue)")
    }
    
    var tab: UITabBarItem {
        let tabItem = UITabBarItem(title: self.title,
                                  image: self.icon,
                                  selectedImage: self.icon)
        tabItem.imageInsets = UIEdgeInsets.init(top: 6,left: 0,bottom: 6,right: 0)
        return tabItem
    }
}

class MainTabBarController: UITabBarController {
    
    private let _tabbar = DownTabbar()
    
    private let home = TabType.down.navigationScreen
    private let approve = TabType.snapmatch.navigationScreen
    private var tasks = TabType.visitors.navigationScreen
    private let feedback = TabType.chats.navigationScreen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTabbar()
        self.viewControllers = [home, approve, tasks, feedback]
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, DownTabbar.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTabbar() {
        
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.black
            appearance.stackedItemPositioning = .centered
            appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = UIOffset(horizontal: -8, vertical: 6)
            appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -8, vertical: 6)
                
            self.tabBar.standardAppearance = appearance
            
            self.customizeAppearance()
        } else {
            // Fallback on earlier versions
        }
        
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().isTranslucent = true
        
        self.tabBar.isTranslucent = false
        
        if #available(iOS 15.0, *) {
            self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func customizeAppearance() {
        if #available(iOS 13.0, *) {
            let appearance = tabBar.standardAppearance.copy()
            setTabBarItemBadgeAppearance(appearance.stackedLayoutAppearance)
            setTabBarItemBadgeAppearance(appearance.inlineLayoutAppearance)
            setTabBarItemBadgeAppearance(appearance.compactInlineLayoutAppearance)
            tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
        }
    }
    
    @available(iOS 13.0, *)
    private func setTabBarItemBadgeAppearance(_ itemAppearance: UITabBarItemAppearance) {
        itemAppearance.normal.badgeBackgroundColor = .red
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9),
                          NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        itemAppearance.normal.titleTextAttributes = attributes
    }
}
