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
    var hostingView: NSHostingView<StatusBarTickerDisplay>
}

class StatusBar {
    private static let HOSTING_VIEW_INITIAL_WIDTH: CGFloat = 800;
    private var statusBarItems = [NSStatusItem]()
    private var statusBarDisplayByTicker = [String: StatusBarViewContainer]()
    
    func updateStatusBarTickers(tickerDatum: [StatusBarTickerData]) {
        for tickerData in tickerDatum {
            let statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
            let view = NSHostingView(rootView: StatusBarTickerDisplay(onSizeChange: onSizeChange, data: tickerData))
            view.setFrameSize(NSSize(width: StatusBar.HOSTING_VIEW_INITIAL_WIDTH, height: NSStatusBar.system.thickness))
            statusBarDisplayByTicker[tickerData.ticker] = StatusBarViewContainer(statusBarItem: statusBarItem, hostingView: view)
            statusBarItem.button?.addSubview(view)
        }
    }
    
    func onSizeChange(tickerSize: TickerSize) {
        let container = statusBarDisplayByTicker[tickerSize.ticker]
        container?.hostingView.setFrameSize(NSSize(width: tickerSize.size.width, height: NSStatusBar.system.thickness))
        container?.statusBarItem.length = tickerSize.size.width
    }
}
