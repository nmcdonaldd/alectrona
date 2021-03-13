//
//  Cryptocurrency.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/25/21.
//

import Foundation

struct CryptocurrencyFundamentals: Decodable {
    var regularMarketPreviousClose: Double
    var regularMarketOpen: Double
    var regularMarketDayRange: String
    var fiftyTwoWeekRange: String
    var startDate: Int
    var circulatingSupply: Int
    var marketCap: Int
    var regularMarketVolume: Int
    var shortName: String
    var fullExchangeName: String
}
