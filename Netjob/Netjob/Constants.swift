//
//  Constants.swift
//  Netjob
//
//  Created by Irakli Vashakidze on 01/10/2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation

public struct NetjobConstants {
    public struct Notifications {
        public static let unauthorized = Notification.Name("NotificationKey401ERROR")
        public static let prohibited = Notification.Name("NotificationKey403ERROR")
        public static let triggerManualService = Notification.Name("NotificationKeyTriggerServiceManual")
    }
}
