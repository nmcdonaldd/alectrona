//
//  StatusBarManager.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 8/8/22.
//

import Foundation
import AppKit
import Combine

class StatusBarManager {
    static let shared: StatusBarManager = StatusBarManager()
    
    // Just the default system statusbar
    private let statusBar = NSStatusBar.system
    private var cancellables = [NSStatusItem: Cancellable]()
    
    private init() {/* Inentionally private singleton */}
    
    /// Creates, and returns, the created item
    /// - Parameters:
    ///   - view: the view to display in the NSStatusItem
    ///   - resizeStrategy: the strategy by which NSStatusItems are resized
    /// - Returns: the NSStatusItem created and added to the system StatusBar
    func addItem(
        withView view: NSView,
        resizeStrategy: StatusItemSizeable = .square
    ) -> NSStatusItem {
        let item = statusBar.statusItem(withLength: resizeStrategy.initialLength)
        item.button?.addSubview(view)
        
        // Resize the status item according to the resize strategy
        let resizer = resizeStrategy.sizePublisher.assign(to: \NSStatusItem.length, on: item)
        
        // Save the resizer in our dictionary
        cancellables[item] = resizer
        
        return item
    }
    
    /// Removes the given status item from the system status bar
    /// - Parameter statusItem: the status item to remove
    func removeItem(_ statusItem: NSStatusItem) {
        // First remove the status item
        statusBar.removeStatusItem(statusItem)
        
        // Then cancel the resizer
        cancellables[statusItem]?.cancel()
        
        // And finally remove from our dict
        cancellables.removeValue(forKey: statusItem)
    }
}

struct StatusItemSizeable {
    typealias StatusItemSizePublisher = AnyPublisher<CGFloat, Never>
    
    var initialLength: CGFloat
    var sizePublisher: StatusItemSizePublisher
}

extension StatusItemSizeable {
    /// Static, square size
    static let square = staticSize(NSStatusItem.squareLength)
    
    /// Helper factory function to create `StatusItemResizeable` from a given, static size
    /// - Parameter size: a static size by which a returned `StatusItemResizeable` is configured
    /// - Returns: `StatusItemResizeable` configured for a static size
    static func staticSize(_ size: CGFloat) -> StatusItemSizeable {
        return StatusItemSizeable(
            initialLength: size,
            sizePublisher: Just(size).eraseToAnyPublisher())
    }
}
