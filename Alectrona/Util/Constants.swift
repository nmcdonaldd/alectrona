//
//  Constants.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/9/21.
//

import Foundation
import Defaults

struct NotificationKey {
    static let newTickerAdded = Notification.Name("notificationAdded")
}

struct UserDefaultsKey {
    static let watchlist = "watchlist"
}

struct Spacing {
    static let small: CGFloat = 6
    static let medium: CGFloat = 10
}

struct FeatureKey {
    static let newsStreaming = "STREAM_NEWS"
}

extension Defaults.Keys {
    static let watchlist = Key<[String]>("watchlist", default: [String]())
    static let interfaceStyle = Key<String>("AppleInterfaceStyle", default: "Light")
}
