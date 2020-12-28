//
//  QuoteRunner.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/28/20.
//

import Foundation

class LiveQuoteRunner {
    
    func beginRepeatedWork() {
        let tickers = getTickers()
        getLiveQuotesForTickers(tickers) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.beginDelayedWork()
        }
    }
    
    private func getTickers() -> [String] {
        return ["TTCF","VEEV"]
    }
    
    private func getLiveQuotesForTickers(_ tickers: [String], callback: @escaping () -> Void) {
        let group = DispatchGroup()
        
        for ticker in tickers {
            group.enter()
            QuoteLoader.getLiveQuote(forTicker: ticker, callback: { [weak self] (response: Response<Quote>) in
                guard let strongSelf = self, let quote = response.data else {
                    return
                }
                
                print("Received data for \(ticker): \(quote.price)")
                
                let liveQuote = LiveQuoteStore.shared.getLiveQuoteByTicker(ticker)
                liveQuote.setMarketPrice(quote.price)
                liveQuote.setpercentageGain(strongSelf.calculatePercentageGain(price: quote.price, previousClose: quote.previousClose))
                group.leave()
            })
        }
        
        group.notify(queue: .main) {
            callback()
        }
    }
    
    private func calculatePercentageGain(price: Double, previousClose: Double) -> Double {
        let difference = price - previousClose
        print("Calculated difference: \(difference/previousClose)")
        return difference / previousClose
    }
    
    private func getReloadOffset() -> DispatchTime {
        return .now() + 5
    }
    
    private func beginDelayedWork() {
        DispatchQueue.main.asyncAfter(deadline: getReloadOffset()) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.beginRepeatedWork()
        }
    }
    
}
