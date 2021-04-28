//
//  StatusBarItemBuilder.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 4/25/21.
//

import Foundation
import SwiftUI

class StatusBarItemBuilder<StatusBarContent: View, PopoverContent: View> {
    
    private var view: StatusBarContent?
    private var popoverView: PopoverContent?
    
    @discardableResult
    func view(_ view: StatusBarContent) -> StatusBarItemBuilder {
        self.view = view
        return self
    }
    
    @discardableResult
    func popoverView(_ view: PopoverContent) -> StatusBarItemBuilder {
        self.popoverView = view
        return self
    }
    
    func build() -> StatusBarItem{
        guard let content = view else {
            fatalError("Please add a view, can't do anything without a view, really...")
        }
        return StatusBarItemImpl(view: content, popoverView: popoverView)
    }
    
    private class StatusBarItemImpl: StatusBarItem {
        private let content: StatusBarContent
        private let popoverView: PopoverContent?
        
        private lazy var popover = { NSPopover() }()
        private var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        private lazy var view: NSView = {
            return NSHostingView(rootView: StatusBarView(content: content, onSizeChange: { [unowned self] size in
                self.view.setFrameSize(NSSize(width: size.width, height: NSStatusBar.system.thickness))
                self.statusItem.length = size.width
            }))
        }()
        
        @discardableResult
        init(view: StatusBarContent, popoverView: PopoverContent?) {
            content = view;
            self.popoverView = popoverView
            
            if(self.popoverView != nil) {
                // Let's add some popover-related action to the status button
                popover.behavior = .transient
                statusItem.button?.addSubview(self.view)
                statusItem.button?.action = #selector(onButtonClick)
                
                // Necessary so AppDelegate doesn't implicitly receive the action
                statusItem.button?.target = self
            }
        }
        
        @objc private func onButtonClick() {
            guard let guaranteedPopoverView = popoverView else {
                return
            }
            
            NSApplication.shared.activate(ignoringOtherApps: true)
            if(popover.isShown) {
                popover.close()
            } else {
                guard let button = statusItem.button else {
                    return
                }
                
                popover.contentViewController = NSHostingController(rootView: guaranteedPopoverView)
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
        
        func remove() {
            NSStatusBar.system.removeStatusItem(statusItem)
        }
    }
}

private struct StatusBarView<Content>: View where Content: View {
    let content: Content
    let onSizeChange: (CGSize) -> Void
    
    init(content: Content, onSizeChange: @escaping (CGSize) -> Void) {
        self.onSizeChange = onSizeChange
        self.content = content
    }
    
    var body: some View {
        content.inStatusBar(onSizeChange: onSizeChange)
    }
}
