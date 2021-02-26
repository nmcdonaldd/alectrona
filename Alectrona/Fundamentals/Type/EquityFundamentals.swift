//
//  Equity.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/25/21.
//

import Foundation

struct EquityFundamentalsResponse: Decodable {
    var marketCap: Int
    var regularMarketOpen: Double
    var bid: Double
    var bidSize: Int
    var ask: Double
    var askSize: Int
    var regularMarketDayRange: String
    var fiftyTwoWeekRange: String
    var regularMarketPreviousClose: Double
    var regularMarketVolume: Int
    var trailingPE: Double?
    var earningsTimestamp: Int?
    var epsTrailingTwelveMonths: Double?
}
