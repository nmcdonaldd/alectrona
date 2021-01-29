//
//  LiveQuoteBackgroundJob.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/28/21.
//

import Foundation
import Combine

struct LiveQuoteBackgroundJob: BackgroundJobConfiguration {
    typealias JobOutput = Quote
    
    private static let BASE_QUOTE = Quote(regularMarketPrice: 0.0, chartPreviousClose: 0.0)
    private let quoteController = QuoteController()
    private let symbol: String
    
    var jobIdentifier: String
    var interval = 5.0
    var quality: QualityOfService = .userInitiated
    var repeats = true
    
    init(symbol: String) {
        self.symbol = symbol
        jobIdentifier = "com.nickdonald.alectrona.\(symbol).quoteLoade"
    }
    
    func doJob() -> AnyPublisher<Quote, Never> {
        return quoteController.guaranteedQuote(forSymbol: symbol)
    }
}
