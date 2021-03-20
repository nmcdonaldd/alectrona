//
//  TickerQuoteStatusItemModel.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/3/21.
//

import Foundation
import Combine
import Resolver

class TickerQuoteStatusItemModel {
    
    private let currentFundamentalsValuePublisher = CurrentValueSubject<FundamentalsQuoteTypeResponse, Never>(.empty)
    private let currentNewsFundamentalsValuePublisher = CurrentValueSubject<[News], Never>([News]())
    private var fundamentalsBackgroundJobSubmission: BackgroundJobSubmission<FundamentalsQuoteTypeResponse>!
    private var newsBackgroundJobSubmission: BackgroundJobSubmission<[News]>?
    private var storage = Set<AnyCancellable>()
    private let symbol: String
    
    @Injected private var backgroundJobSubmitter: BackgroundJobSumitter
    @Injected private var fundamentalsController: FundamentalsController
    @Injected private var stockNewsController: StockNewsController
    
    var fundamentalsPublisher: AnyPublisher<FundamentalsQuoteTypeResponse, Never> {
        return currentFundamentalsValuePublisher.eraseToAnyPublisher()
    }
    
    var newsPublisher: AnyPublisher<[News], Never> {
        return currentNewsFundamentalsValuePublisher.eraseToAnyPublisher()
    }
    
    init(symbol: String) {
        self.symbol = symbol
    }
    
    func repeatedLoad() {
        fundamentalsBackgroundJobSubmission = backgroundJobSubmitter.submit(jobConfiguration: FundamentalsBackgroundJob(symbol: symbol))
        
        if(Features.newsStreaming) {
            newsBackgroundJobSubmission = backgroundJobSubmitter.submit(jobConfiguration: NewsBackgroundJobConfiguration(symbol: symbol))
            stockNewsController.getStockNews(forSymbol: symbol)
                .append(newsBackgroundJobSubmission!.publisher)
                .sink { self.currentNewsFundamentalsValuePublisher.send($0) }
                .store(in: &storage)
        }
        
        fundamentalsController.getFundamentals(forSymbol: symbol)
            .append(fundamentalsBackgroundJobSubmission.publisher)
            .sink { self.currentFundamentalsValuePublisher.send($0) }
            .store(in: &storage)
    }
    
    func cancel() {
        fundamentalsBackgroundJobSubmission.cancelJob()
        newsBackgroundJobSubmission?.cancelJob()
    }
}
