//
//  LiveQuote.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/2/21.
//

import Foundation
import Combine

class LiveQuote: ObservableObject {
    static let BASE_QUOTE = Quote(regularMarketPrice: 0.0, chartPreviousClose: 0.0)
    let symbol: String
    
    private var cancellables: Set<AnyCancellable> = []
    private var quoteController = QuoteController()
    
    @Published var percentageGain: Double = 0.0
    @Published var regularMarketPrice: Double = 0.0
    
    private var repeatedWorkPublisher: AnyPublisher<Timer.TimerPublisher.Output, Timer.TimerPublisher.Failure> {
        Timer.publish(every: 5.0, on: .main, in: .default)
            .autoconnect()
            .eraseToAnyPublisher()
    }
    
    private lazy var quotePublisher: AnyPublisher<Quote, Error> = {
        repeatedWorkPublisher
            .receive(on: RunLoop.main)
            .flatMap({ _ in self.getQuote() })
            .eraseToAnyPublisher()
    }()
    
    private func getQuote() -> AnyPublisher<Quote, Error> {
        return self.quoteController.getQuote(forSymbol: symbol)
    }
    
    init(symbol: String) {
        self.symbol = symbol
        
        // Loads the quote instantly
        subscribers(forQuotePublisher: getQuote())
        
        // Kicks off repeated loads
        subscribers(forQuotePublisher: quotePublisher)
    }
    
    private func subscribers(forQuotePublisher publisher: AnyPublisher<Quote, Error>) {
        let sharedPublisher = publisher.share()
        
        sharedPublisher
            .receive(on: RunLoop.main)
            .replaceError(with: LiveQuote.BASE_QUOTE)
            .map { $0.percentageGain }
            .assign(to: \.percentageGain, on: self)
            .store(in: &cancellables)
        
        sharedPublisher
            .receive(on: RunLoop.main)
            .replaceError(with: LiveQuote.BASE_QUOTE)
            .map { $0.regularMarketPrice }
            .assign(to: \.regularMarketPrice, on: self)
            .store(in: &cancellables)
    }
}
