//
//  LiveQuote.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/2/21.
//

import Foundation
import Combine

struct LiveCurrentQuote {
    var percentageGain: Double = 0.0
    var regularMarketPrice: Double = 0.0
}

class LiveQuote: ObservableObject {
    let symbol: String
    
    private var cancellables: Set<AnyCancellable> = []
    private var quoteController = QuoteController()
    
    @Published var currentQuote = LiveCurrentQuote()
    
    init(symbol: String) {
        self.symbol = symbol
        
        let submission = BackgroundJobSumitter.submit(jobConfiguration: LiveQuoteBackgroundJob(symbol: symbol))
        
        self.quoteController.guaranteedQuote(forSymbol: symbol)
            .append(submission.publisher)
            .map { LiveCurrentQuote(percentageGain: $0.percentageGain, regularMarketPrice: $0.regularMarketPrice) }
            .receive(on: RunLoop.main)
            .sink { self.currentQuote = $0 }
            .store(in: &cancellables)
    }
}
