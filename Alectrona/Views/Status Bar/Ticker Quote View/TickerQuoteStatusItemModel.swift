//
//  TickerQuoteStatusItemModel.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/3/21.
//

import Foundation
import Combine
import Factory

class TickerQuoteStatusItemModel {
    private let currentFundamentalsValuePublisher = CurrentValueSubject<FundamentalsQuoteTypeResponse, Never>(.empty)
    private let currentNewsFundamentalsValuePublisher = CurrentValueSubject<[News], Never>([News]())
    private var fundamentalsBackgroundJobSubmission: BackgroundJobSubmission<FundamentalsQuoteTypeResponse>!
    private var newsBackgroundJobSubmission: BackgroundJobSubmission<[News]>?
    private var storage = Set<AnyCancellable>()
    private let symbol: String
    
    @Injected(Container.backgroundJobSubmitter)
    private var backgroundJobSubmitter: BackgroundJobSumitter
    
    @Injected(Container.fundamentalsController)
    private var fundamentalsController: FundamentalsController
    
    @Injected(Container.stockNewsController)
    private var stockNewsController: StockNewsController
    
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
                .sink { [unowned self] in
                    self.currentNewsFundamentalsValuePublisher.send($0)
                }
                .store(in: &storage)
        }
        
        fundamentalsController.getFundamentals(forSymbol: symbol)
            .append(fundamentalsBackgroundJobSubmission.publisher)
            .sink { [unowned self] in
                self.currentFundamentalsValuePublisher.send($0)
            }
            .store(in: &storage)
    }
    
    func cancel() {
        fundamentalsBackgroundJobSubmission.cancel()
        newsBackgroundJobSubmission?.cancel()
    }
}
