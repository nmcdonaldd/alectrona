//
//  NewTickerButton.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/29/20.
//

import Foundation
import SwiftUI

class NewTickerButton {
    
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private var popover = NSPopover()
    
    init() {
        statusItem.button?.title = "+"
        statusItem.button?.action = #selector(onButtonClicked)
        
        // Necessary so AppDelegate doesn't implicitly receive the action
        statusItem.button?.target = self
        popover.behavior = .transient
    }
    
    @objc func onButtonClicked() {
        if(popover.isShown) {
            popover.close()
        } else {
            guard let button = statusItem.button else {
                return
            }
            popover.contentViewController = NSHostingController(rootView: NewTickerSelectorView())
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }
}
