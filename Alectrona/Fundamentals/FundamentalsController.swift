//
//  FundamentalsController.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/12/21.
//

import Foundation
import Combine
import Resolver

class FundamentalsController {
    
    @Injected private var api: API
    
    struct FundamentalsControllerError: Error {}
    
    struct FundamentalsResponseContainer: Decodable {
        var quoteResponse: QuoteResponse
        
        struct QuoteResponse: Decodable {
            var result: [FundamentalsQuoteTypeResponse]
        }
    }
    
    func getFundamentals(forSymbol symbol: String) -> AnyPublisher<FundamentalsQuoteTypeResponse, Never> {
        /// Empty `requestedFields` means get us everything. Maybe greedy but I don't want to list it all out just yet. Something to fix later on...
        return api.get(type: FundamentalsResponseContainer.self, url: Endpoint.getFundamentals(forSymbol: symbol, requestedFields: [String]()).url)
            .map { $0.quoteResponse.result[0] }
            .replaceError(with: .empty)
            .eraseToAnyPublisher()
    }
}
