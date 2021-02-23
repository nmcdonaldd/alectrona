//
//  PlistService.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/14/21.
//

import Foundation

class PlistService {
    func getValue<T>(forKey key: String, fromResource resource: String) -> T? {
        return getPlist(withResourceName: resource)?[key] as? T
    }
    
    private func getPlist(withResourceName resource: String) -> [String: Any]? {
        guard let path = Bundle.main.path(forResource: resource, ofType: "plist") else {
            return nil
        }
        
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        return try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: Any]
    }
}
