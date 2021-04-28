//
//  TickerQuoteStatusItem.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/29/20.
//

import Foundation
import SwiftUI
import Combine

class TickerQuoteStatusItem {
    private let symbol: String
    private var tickerQuoteStatusItemModel: TickerQuoteStatusItemModel
    private let statusBarItem: StatusBarItem
    
    init(symbol: String) {
        self.symbol = symbol
        tickerQuoteStatusItemModel = TickerQuoteStatusItemModel(symbol: symbol)
        tickerQuoteStatusItemModel.repeatedLoad()
        statusBarItem = StatusBarItemBuilder()
            .view(StatusBarTickerDisplay(symbol: symbol))
            .popoverView(LiveQuotePopoverView(fundamentalsViewModel: FundamentalsViewModel(fundamentalsPublisher: tickerQuoteStatusItemModel.fundamentalsPublisher, newsPublisher: tickerQuoteStatusItemModel.newsPublisher)))
            .build()
    }
    
    func remove() {
        tickerQuoteStatusItemModel.cancel()
        statusBarItem.remove()
    }
}
