//
//  AppDelegate+Injection.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/13/21.
//

import Factory

extension Container {
    private static func singleton<T>(factory: @escaping () -> T) -> Factory<T> {
        return Factory(scope: .singleton, factory: factory)
    }
    
    static let newsController = singleton { NewsController() }
    static let newsLinkController = singleton { NewsLinkController() }
    static let stockNewsController = singleton { StockNewsController() }
    static let backgroundJobSubmitter = singleton { BackgroundJobSumitter() }
    static let fundamentalsController = singleton { FundamentalsController() }
    static let quoteController = singleton { QuoteController() }
    static let ticketController = singleton { TickerController() }
    static let api = singleton { API() }
    static let htmlScraper = singleton { HTMLScraper() }
    static let plistService = singleton { PlistService() }
    static let quoteStreamer = singleton { QuoteStreamer() }
}
