//
//  UserDefaultsHelper.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/9/21.
//

import Foundation

class UserDefaultsHelper {
    
    static func getValue<T>(forKey key: String, fromUserDefaults userDefaults: UserDefaults = .standard) -> T? {
        return getValue(forKey: key, fromUserDefaults: userDefaults, withDefaultValue: nil)
    }
    
    static func getValue<T>(forKey key: String, fromUserDefaults userDefaults: UserDefaults = .standard, withDefaultValue defaultValue: T?) -> T? {
        return userDefaults.value(forKey: key) as? T ?? defaultValue
    }
    
    static func setValue<T>(forKey key: String, value: T?, toUserDefaults userDefaults: UserDefaults = .standard) {
        userDefaults.setValue(value, forKey: key)
    }
}
