//
//  Cryptocurrency.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/25/21.
//

import Foundation

struct CryptocurrencyFundamentalsResponse: Decodable {
    var regularMarketPreviousClose: Double
    var regularMarketOpen: Double
    var regularMarketChange: Double
    var regularMarketDayRange: String
    var fiftyTwoWeekRange: String
    var startDate: Int
    var marketCap: Int
    var regularMarketVolume: Int
}
