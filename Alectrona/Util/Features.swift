//
//  Features.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/14/21.
//

import Foundation
import Resolver
import YMFF

private class PlistBackedFeatureStore: FeatureFlagStoreProtocol {
    
    @Injected private var plistService: PlistService
    
    fileprivate static let shared = PlistBackedFeatureStore()
    
    private init() {}
    
    func value<Value>(forKey key: String) -> Value? {
        return plistService.getValue(forKey: key, fromResource: "Features")
    }
}

enum Features {
    private static var resolver: FeatureFlagResolverProtocol = {
        FeatureFlagResolver(configuration: .init(persistentStores: [
            .opaque(PlistBackedFeatureStore.shared)
        ]))
    }()
    
    @FeatureFlag(FeatureKey.newsStreaming, default: false, resolver: resolver)
    static var newsStreaming
}
