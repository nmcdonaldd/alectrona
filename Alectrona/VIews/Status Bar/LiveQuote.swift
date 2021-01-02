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
    
    @Published var quote: Quote = BASE_QUOTE
    
    private var repeatedWorkPublisher: AnyPublisher<Timer.TimerPublisher.Output, Timer.TimerPublisher.Failure> {
        Timer.publish(every: 5.0, on: .main, in: .default)
            .autoconnect()
            .eraseToAnyPublisher()
    }
    
    private var quotePublisher: AnyPublisher<Quote, Error> {
        repeatedWorkPublisher
            .receive(on: RunLoop.main)
            .flatMap({ [unowned self] (_) in
                return self.quoteController.getQuote(forSymbol: symbol)
            })
            .eraseToAnyPublisher()
    }
    
    init(symbol: String) {
        self.symbol = symbol
        
        quotePublisher
            .receive(on: RunLoop.main)
            .replaceError(with: LiveQuote.BASE_QUOTE)
            .assign(to: \.quote, on: self)
            .store(in: &cancellables)
    }
}
