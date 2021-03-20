//
//  ETFFundamentals.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/27/21.
//

import Foundation

struct ETFFundamentals: Decodable {
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
    var longName: String
    var fullExchangeName: String
    var trailingPE: Double?
}
