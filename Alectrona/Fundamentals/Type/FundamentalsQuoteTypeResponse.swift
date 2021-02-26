//
//  FundamentalsQuoteTYpe.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/25/21.
//

import Foundation

enum FundamentalsQuoteTypeResponse: Decodable {
    struct ResultMetadata: Decodable {
        var quoteType: QuoteType
    }
    
    case cryptoCurrency(CryptocurrencyFundamentalsResponse)
    case equity(EquityFundamentalsResponse)
    
    ///TODO: remove this. This is mainly as a fallback for errors. I should actually handle errors correctly, though.
    case empty
    
    init(from decoder: Decoder) throws {
        let metadata = try ResultMetadata(from: decoder)
        switch metadata.quoteType {
        case .CRYPTOCURRENCY: self = try .cryptoCurrency(CryptocurrencyFundamentalsResponse(from: decoder))
        case .EQUITY: self = try .equity(EquityFundamentalsResponse(from: decoder))
        }
    }
}
