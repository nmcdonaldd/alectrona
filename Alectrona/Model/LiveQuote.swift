//
//  Ticker.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/27/20.
//

import Foundation

class LiveQuote: ObservableObject {
    @Published var fairMarketPrice: Double = 0.0
    @Published var percentageGain: Double = 0.0
    
    func setMarketPrice(_ price: Double) {
        fairMarketPrice = price
    }
    
    func setpercentageGain(_ gain: Double) {
        percentageGain = gain
    }
}
