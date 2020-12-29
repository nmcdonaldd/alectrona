//
//  QuoteRunner.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/28/20.
//

import Foundation

protocol LiveQuoteDelegate {
    func onLiveQuoteLoaded(_ quote: Quote, forTicker ticker: String)
}

class LiveQuoteRunner {
    
    var delegate: LiveQuoteDelegate?
    
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
                
                strongSelf.delegate?.onLiveQuoteLoaded(quote, forTicker: ticker)
                group.leave()
            })
        }
        
        group.notify(queue: .main) {
            callback()
        }
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
