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
    private var storage: AnyCancellable?
    
    init() {
        storage = Defaults.publisher(.watchlist)
            .map(\.newValue)
            .sink(receiveValue: { [weak self] (symbols) in
                self?.displayedTickers.forEach({ $0.remove() })
                for ticker in symbols {
                    self?.displayedTickers.append(TickerQuoteStatusItem(symbol: ticker))
                }
            })
    }
}
