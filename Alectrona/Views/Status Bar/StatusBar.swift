//
//  StatusBar.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/24/20.
//

import Foundation
import SwiftUI

class StatusBar {
    private let newTickerButton = NewTickerButton()
    private var displayedTickers = [TickerQuoteStatusItem]()
    
    init() {
        refreshTickers()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshTickers),
                                               name: NotificationKey.newTickerAdded,
                                               object: nil)
    }
    
    @objc private func refreshTickers() {
        removeAllTickerDisplays()
        renderTickers()
    }
    
    private func removeAllTickerDisplays() {
        displayedTickers.forEach({ $0.remove() })
    }
    
    private func renderTickers() {
        let tickers = getTickersToDisplay()
        for ticker in tickers {
            displayedTickers.append(TickerQuoteStatusItem(ticker: ticker))
        }
    }
    
    func getTickersToDisplay() -> [String] {
        return UserDefaults.standard.array(forKey: UserDefaultsKey.watchlist) as? [String] ?? [String]()
    }
}
