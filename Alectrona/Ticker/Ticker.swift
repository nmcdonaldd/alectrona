//
//  TickerSearchResults.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/1/21.
//

import Foundation

struct Ticker: Decodable {
    var exchange: String
    var quoteType: String
    var symbol: String
    var longname: String?
}
