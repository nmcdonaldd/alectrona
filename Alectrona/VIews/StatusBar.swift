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
    private static let HOSTING_VIEW_INITIAL_WIDTH: CGFloat = 800;
    private var statusBarItems = [NSStatusItem]()
    private var statusBarDisplayByTicker = [String: StatusBarViewContainer]()
    
    init() {
        renderTickers()
    }
    
    private func renderTickers() {
        // FIXME: move to some environment variable
        let tickers = getTickersToDisplay()
        for ticker in tickers {
            let statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
            let hostingView = NSHostingView(rootView: StatusBarTickerDisplay(ticker: ticker, onSizeChange: onSizeChange).environmentObject(LiveQuoteStore.shared.getLiveQuoteByTicker(ticker)))
            hostingView.setFrameSize(NSSize(width: 0, height: NSStatusBar.system.thickness))
            statusBarDisplayByTicker[ticker] = StatusBarViewContainer(statusBarItem: statusBarItem, hostingView: hostingView)
            statusBarItem.button?.addSubview(hostingView)
        }
    }
    
    func getTickersToDisplay() -> [String] {
        return ["TTCF", "VEEV"]
    }
    
    func onSizeChange(tickerSize: TickerSize) {
        let container = statusBarDisplayByTicker[tickerSize.ticker]
        container?.hostingView.setFrameSize(NSSize(width: tickerSize.size.width, height: NSStatusBar.system.thickness))
        container?.statusBarItem.length = tickerSize.size.width
        print("Width change!! \(tickerSize.ticker)")
        print(tickerSize.size.width)
    }
}
