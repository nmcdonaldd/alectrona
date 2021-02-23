//
//  StatusBar.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/24/20.
//

import Foundation
import SwiftUI
import Combine
import Defaults

class StatusBar {
    private let newTickerButton = NewTickerButton()
    private var displayedTickers = [TickerQuoteStatusItem]()
    
    /// Can't find a way to reference `self` in the `sink` usage below unless this is optional
    private var storage: AnyCancellable?
    
    init() {
        storage = Defaults.publisher(.watchlist)
            .map(\.newValue)
            .sink(receiveValue: { symbols in
                self.displayedTickers.forEach({ $0.remove() })
                self.displayedTickers.removeAll()
                for ticker in symbols {
                    self.displayedTickers.append(TickerQuoteStatusItem(symbol: ticker))
                }
            })
    }
}
