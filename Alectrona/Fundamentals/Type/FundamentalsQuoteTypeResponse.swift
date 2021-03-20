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
    
    case cryptocurrency(CryptocurrencyFundamentals)
    case equity(EquityFundamentals)
    case etf(ETFFundamentals)
    
    ///TODO: remove this. This is mainly as a fallback for errors. I should actually handle errors correctly, though.
    case empty
    
    init(from decoder: Decoder) throws {
        let metadata = try ResultMetadata(from: decoder)
        switch metadata.quoteType {
        case .ETF: self = try .etf(ETFFundamentals(from: decoder))
        case .EQUITY: self = try .equity(EquityFundamentals(from: decoder))
        case .CRYPTOCURRENCY: self = try .cryptocurrency(CryptocurrencyFundamentals(from: decoder))
        }
    }
}
