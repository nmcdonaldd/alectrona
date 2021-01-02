//
//  Quote.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/1/21.
//

import Foundation

struct Quote: Decodable {
    var regularMarketPrice: Double
    var chartPreviousClose: Double
    
    var percentageGain: Double {
        return (regularMarketPrice - chartPreviousClose) / chartPreviousClose
    }
}
