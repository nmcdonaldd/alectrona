//
//  NewsBackgroundJob.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/4/21.
//

import Foundation
import Combine
import Resolver

class NewsBackgroundJobConfiguration: BackgroundJobConfiguration {
    typealias JobOutput = [News]
    
    var jobIdentifier: String
    var interval: Double = 60*5 // 5 minutes
    var quality: QualityOfService = .utility
    private let symbol: String
    
    @Injected private var newsController: StockNewsController
    
    init(symbol: String) {
        self.symbol = symbol
        self.jobIdentifier = "com.nickdonald.alectrona.\(symbol).news"
    }
    
    func doJob() -> AnyPublisher<[News], Never> {
        return newsController.getStockNews(forSymbol: symbol)
    }
}
