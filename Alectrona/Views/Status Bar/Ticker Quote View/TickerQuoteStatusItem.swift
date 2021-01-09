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
    private var popover = NSPopover()
    
    init(ticker: String) {
        hostingView = NSHostingView(rootView: StatusBarTickerDisplay(symbol: ticker, onSizeChange: onSizeChange))
        
        // Set up button
        statusItem.button?.addSubview(hostingView)
        statusItem.button?.action = #selector(onButtonClicked)
        
        // Necessary so AppDelegate doesn't implicitly receive the action
        statusItem.button?.target = self
    }
    
    private func onSizeChange(_ size: CGSize) {
        hostingView.setFrameSize(NSSize(width: size.width, height: NSStatusBar.system.thickness))
        statusItem.length = size.width
    }
    
    @objc func onButtonClicked() {
        if(popover.isShown) {
            popover.close()
        } else {
            guard let button = statusItem.button else {
                return
            }
            popover.contentViewController = NSHostingController(rootView: LiveQuotePopoverView())
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minX)
        }
    }
    
    func remove() {
        NSStatusBar.system.removeStatusItem(statusItem)
    }
}
