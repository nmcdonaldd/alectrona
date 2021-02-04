//
//  FundamentalsBackgroundJob.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/2/21.
//

import Foundation
import Combine

class FundamentalsBackgroundJob: BackgroundJobConfiguration {
    typealias JobOutput = Fundamentals
    
    var jobIdentifier: String
    var interval: Double = 60   // 60 Seconds
    var quality: QualityOfService = .utility
    var repeats: Bool = true
    
    private let symbol: String
    private var fundamentalsController = FundamentalsController()
    
    init(symbol: String) {
        self.symbol = symbol
        jobIdentifier = "com.nickdonald.alectrona.\(symbol).fundamentals"
    }
    
    func doJob() -> AnyPublisher<Fundamentals, Never> {
        return fundamentalsController.getFundamentals(forSymbol: symbol)
    }
}
