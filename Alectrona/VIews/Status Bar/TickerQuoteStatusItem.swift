//
//  TickerQuoteStatusItem.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/29/20.
//

import Foundation
import SwiftUI

class TickerQuoteStatusItem {
    private var statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private var hostingView: NSView!
    
    init(ticker: String) {
        hostingView = NSHostingView(rootView: StatusBarTickerDisplay(symbol: ticker, onSizeChange: onSizeChange))
        statusItem.button?.addSubview(hostingView)
    }
    
    private func onSizeChange(_ size: CGSize) {
        hostingView.setFrameSize(NSSize(width: size.width, height: NSStatusBar.system.thickness))
        statusItem.length = size.width
    }
}
