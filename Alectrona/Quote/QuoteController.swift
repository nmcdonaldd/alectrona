//
//  QuoteController.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/1/21.
//

import Foundation
import Combine

class QuoteController {
    private static let BASE_QUOTE = Quote(regularMarketPrice: 0.0, chartPreviousClose: 0.0)
    
    private struct ChartResult: Decodable {
        var chart: ChartMetaResultContainer
    }
    private struct ChartMetaResultContainer: Decodable {
        var result: [MetaResult]
    }
    private struct MetaResult: Decodable {
        var meta: Quote
    }
    
    func getQuote(forSymbol symbol: String) -> AnyPublisher<Quote, Error> {
        let endpoint = Endpoint.getQuote(forSymbol: symbol)
        return API.get(type: ChartResult.self, url: endpoint.url)
            .map { $0.chart.result[0].meta }
            .eraseToAnyPublisher()
    }
    
    func guaranteedQuote(forSymbol symbol: String) -> AnyPublisher<Quote, Never> {
        return getQuote(forSymbol: symbol)
            .replaceError(with: QuoteController.BASE_QUOTE)
            .eraseToAnyPublisher()
    }
}
