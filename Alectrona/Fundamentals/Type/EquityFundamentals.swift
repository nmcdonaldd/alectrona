//
//  Equity.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/25/21.
//

import Foundation

struct EquityFundamentals: Decodable {
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
    var averageDailyVolume3Month: Int
    var longName: String
    var fullExchangeName: String
    var trailingPE: Double?
    var earningsTimestampStart: Int?
    var earningsTimestampEnd: Int?
    var epsTrailingTwelveMonths: Double?
}
