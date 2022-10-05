//
//  FundamentalsBackgroundJob.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/2/21.
//

import Foundation
import Combine
import Factory

class FundamentalsBackgroundJob: BackgroundJobConfiguration {
    typealias JobOutput = FundamentalsQuoteTypeResponse
    
    var jobIdentifier: String
    var interval: Double = 2   // 30 Seconds
    var quality: QualityOfService = .userInitiated
    
    private let symbol: String
    
    @Injected(Container.fundamentalsController)
    private var fundamentalsController: FundamentalsController
    
    init(symbol: String) {
        self.symbol = symbol
        jobIdentifier = "com.nickdonald.alectrona.\(symbol).fundamentals"
    }
    
    func doJob() -> AnyPublisher<FundamentalsQuoteTypeResponse, Never> {
        return fundamentalsController.getFundamentals(forSymbol: symbol)
    }
}
