//
//  LiveQuote.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/2/21.
//

import Foundation
import Combine
import Factory

struct LiveCurrentQuote {
    var percentageGain: Double = 0.0
    var regularMarketPrice: Double = 0.0
}

class LiveQuote: ObservableObject {
    let symbol: String
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Injected(Container.quoteController) private var quoteController: QuoteController
    
    @Injected(Container.quoteStreamer) private var quoteStreamer: QuoteStreamer
    
    @Injected(Container.backgroundJobSubmitter)
    private var backgroundJobSubmitter: BackgroundJobSumitter
    
    @Published var currentQuote = LiveCurrentQuote()
    
    private var currentLiveQuoteSubject = PassthroughSubject<Quote, Never>()
    
    // Not sure if this is a hack or not, I couldn't get the reference to self.quoteStreamer
    // to work in the initalizer for this field unless I did a private(set)
    private(set) var liveQuoteStream: LiveQuoteStream!
    
    init(symbol: String) {
        self.symbol = symbol
        
        liveQuoteStream = quoteStreamer.streamQuote(forSymbol: symbol)
        liveQuoteStream.publisher
            .sink { [unowned self] in self.currentLiveQuoteSubject.send($0) }
            .store(in: &cancellables)
        
        quoteController.guaranteedQuote(forSymbol: symbol)
            .sink { [unowned self] in self.currentLiveQuoteSubject.send($0) }
            .store(in: &cancellables)
        
        currentLiveQuoteSubject
            .map { LiveCurrentQuote(percentageGain: $0.percentageGain, regularMarketPrice: $0.regularMarketPrice) }
            .receive(on: RunLoop.main)
            .assign(to: &$currentQuote)
    }
    
    deinit {
        liveQuoteStream.cancel()
    }
}
