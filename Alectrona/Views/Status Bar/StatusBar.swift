//
//  StatusBar.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/24/20.
//

import Foundation
import SwiftUI

struct StatusBarViewContainer {
    var statusBarItem: NSStatusItem
    var hostingView: NSView
}

class StatusBar {
    private let newTickerButton = NewTickerButton()
    
    init() {
        renderTickers()
    }
    
    private func renderTickers() {
        /// FIXME: move to some environment variable
        let tickers = getTickersToDisplay()
        for ticker in tickers {
            TickerQuoteStatusItem(ticker: ticker)
        }
    }
    
    func getTickersToDisplay() -> [String] {
        return ["TTD", "LMND"]
    }
}
