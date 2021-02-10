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
    private let currentNewsFundamentalsValuePublisher = CurrentValueSubject<[News], Never>([News]())
    private var fundamentalsBackgroundJobSubmission: BackgroundJobSubmission<Fundamentals>
    private var newsBackgroundJobSubmission: BackgroundJobSubmission<[News]>
    private var storage = Set<AnyCancellable>()
    
    var fundamentalsPublisher: AnyPublisher<Fundamentals, Never> {
        return currentFundamentalsValuePublisher.eraseToAnyPublisher()
    }
    
    var newsPublisher: AnyPublisher<[News], Never> {
        return currentNewsFundamentalsValuePublisher.eraseToAnyPublisher()
    }
    
    init(symbol: String) {
        fundamentalsBackgroundJobSubmission = BackgroundJobSumitter.submit(jobConfiguration: FundamentalsBackgroundJob(symbol: symbol))
        newsBackgroundJobSubmission = BackgroundJobSumitter.submit(jobConfiguration: NewsBackgroundJobConfiguration(symbol: symbol))
        
        FundamentalsController().getFundamentals(forSymbol: symbol)
            .append(fundamentalsBackgroundJobSubmission.publisher)
            .sink { self.currentFundamentalsValuePublisher.send($0) }
            .store(in: &storage)

        StockNewsController().getStockNews(forSymbol: symbol)
            .append(newsBackgroundJobSubmission.publisher)
            .sink { self.currentNewsFundamentalsValuePublisher.send($0) }
            .store(in: &storage)
    }
    
    func cancel() {
        fundamentalsBackgroundJobSubmission.cancelJob()
        newsBackgroundJobSubmission.cancelJob()
    }
}
