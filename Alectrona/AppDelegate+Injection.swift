//
//  AppDelegate+Injection.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/13/21.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { NewsController() }
        register { NewsLinkController() }
        register { StockNewsController() }
        register { BackgroundJobSumitter() }
        register { FundamentalsController() }
        register { FundamentalsScraper() }
        register { QuoteController() }
        register { TickerController() }
        register { API() }
        register { HTMLScraper() }
        register { PlistService() }
    }
}
