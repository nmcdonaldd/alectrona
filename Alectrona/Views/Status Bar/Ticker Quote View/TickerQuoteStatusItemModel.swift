//
//  TickerQuoteStatusItemModel.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/3/21.
//

import Foundation
import Combine

class TickerQuoteStatusItemModel {
    
    private let currentFundamentalsValuePublisher = CurrentValueSubject<Fundamentals, Never>(.empty)
    private var backgroundJobSubmission: BackgroundJobSubmission<Fundamentals>
    private var storage = Set<AnyCancellable>()
    
    var fundamentalsPublisher: AnyPublisher<Fundamentals, Never> {
        return currentFundamentalsValuePublisher.eraseToAnyPublisher()
    }
    
    init(symbol: String) {
        backgroundJobSubmission = BackgroundJobSumitter.submit(jobConfiguration: FundamentalsBackgroundJob(symbol: symbol))
        FundamentalsController().getFundamentals(forSymbol: symbol)
            .append(backgroundJobSubmission.publisher)
            .sink { self.currentFundamentalsValuePublisher.send($0) }
            .store(in: &storage)
    }
    
    func cancel() {
        backgroundJobSubmission.cancelJob()
    }
}
