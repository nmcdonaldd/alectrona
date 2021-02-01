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
    private let popover = NSPopover()
    private let symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
        hostingView = NSHostingView(rootView: StatusBarTickerDisplay(symbol: symbol, onSizeChange: onSizeChange))
        
        // Set up button
        statusItem.button?.addSubview(hostingView)
        statusItem.button?.action = #selector(onButtonClicked)
        
        // Necessary so AppDelegate doesn't implicitly receive the action
        statusItem.button?.target = self
        popover.behavior = .transient
    }
    
    private func onSizeChange(_ size: CGSize) {
        hostingView.setFrameSize(NSSize(width: size.width, height: NSStatusBar.system.thickness))
        statusItem.length = size.width
    }
    
    @objc func onButtonClicked() {
        // For some reason, the ticker detail popover does not clear even when it's set to .transient
        NSApplication.shared.activate(ignoringOtherApps: true)
        if(popover.isShown) {
            popover.close()
        } else {
            guard let button = statusItem.button else {
                return
            }
            popover.contentViewController = NSHostingController(rootView: LiveQuotePopoverView(fundamentalsViewModel: FundamentalsViewModel(symbol: symbol)))
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }
    
    func remove() {
        NSStatusBar.system.removeStatusItem(statusItem)
    }
}
