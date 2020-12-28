//
//  LiveQuoteStore.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/27/20.
//

import Foundation

class LiveQuoteStore {
    private var liveQuoteByTicker = [String: LiveQuote]()
    
    static let shared = LiveQuoteStore()
    private init() { }
    
    func updateQuoteForTicker(_ ticker: String, price: Double, percentageGain: Double) {
        liveQuoteByTicker[ticker]?.setMarketPrice(price)
        liveQuoteByTicker[ticker]?.setpercentageGain(percentageGain)
    }
    
    func getLiveQuoteByTicker(_ ticker: String) -> LiveQuote {
        if(liveQuoteByTicker[ticker] == nil) {
            liveQuoteByTicker[ticker] = LiveQuote()
        }
        
        return liveQuoteByTicker[ticker]!
    }
}
