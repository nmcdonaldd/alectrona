//
//  LiveQuoteStore.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/27/20.
//

import Foundation

class LiveQuoteStore {
    fileprivate var liveQuoteByTicker = [String: LiveQuote]()
    
    static let shared = LiveQuoteStore()
    private init() { }
    
    func getLiveQuoteByTicker(_ ticker: String) -> LiveQuote {
        if(liveQuoteByTicker[ticker] == nil) {
            liveQuoteByTicker[ticker] = LiveQuote()
        }
        
        return liveQuoteByTicker[ticker]!
    }
}

extension LiveQuoteStore: LiveQuoteDelegate {
    func onLiveQuoteLoaded(_ quote: Quote, forTicker ticker: String) {
        let liveQuote = getLiveQuoteByTicker(ticker)
        liveQuote.fairMarketPrice = quote.price
        liveQuote.percentageGain = LiveQuoteStore.calculatePercentageGain(price: quote.price, previousClose: quote.previousClose)
    }
    
    private class func calculatePercentageGain(price: Double, previousClose: Double) -> Double {
        let difference = price - previousClose
        return difference / previousClose
    }
}
