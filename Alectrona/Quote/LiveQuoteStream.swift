//
//  LiveQuoteStream.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 3/23/21.
//

import Foundation
import Combine

struct LiveQuoteStream: Cancellable {
    private let quotePublisher: AnyPublisher<Quote, Never>
    private let cancelDelegate: Canceller

    var publisher: AnyPublisher<Quote, Never> {
        quotePublisher.eraseToAnyPublisher()
    }
    
    init(quotePublisher: AnyPublisher<Quote, Never>, canceller: Canceller) {
        cancelDelegate = canceller
        self.quotePublisher = quotePublisher
    }
    
    func cancel() {
        cancelDelegate.cancel()
    }
}
