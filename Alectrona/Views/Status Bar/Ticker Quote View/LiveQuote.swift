//
//  LiveQuote.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/2/21.
//

import Foundation
import Combine

class LiveQuote: ObservableObject {
    let symbol: String
    
    private var cancellables: Set<AnyCancellable> = []
    private var quoteController = QuoteController()
    
    @Published var percentageGain: Double = 0.0
    @Published var regularMarketPrice: Double = 0.0
    
    init(symbol: String) {
        self.symbol = symbol
        
        let submission = BackgroundJobSumitter.submit(jobConfiguration: LiveQuoteBackgroundJob(symbol: symbol))
        
        let repeatedQuoteLoadPublisher = Deferred { self.quoteController.guaranteedQuote(forSymbol: symbol) }
            .append(submission.publisher)
            .print()
            .share()
            .eraseToAnyPublisher()
        
        assignSubscriber(forQuotePublisher: repeatedQuoteLoadPublisher, assignTo: \.percentageGain) { $0.percentageGain }
        assignSubscriber(forQuotePublisher: repeatedQuoteLoadPublisher, assignTo: \.regularMarketPrice) { $0.regularMarketPrice }
    }
    
    private func assignSubscriber<Output>(forQuotePublisher quotePublisher: AnyPublisher<Quote, Never>, assignTo keyPath:  ReferenceWritableKeyPath<LiveQuote, Output>, transformer: @escaping (Quote) -> Output) {
        quotePublisher
            .map(transformer)
            .receive(on: RunLoop.main)
            .assign(to: keyPath, on: self)
            .store(in: &cancellables)
    }
}
