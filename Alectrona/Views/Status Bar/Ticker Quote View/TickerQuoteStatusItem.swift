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
    private var statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private var hostingView: NSView!
    private let popover = NSPopover()
    private let symbol: String
    
    /// FIXME: Move to model somewhere else
    private var fundamentalsPublisher: CurrentValueSubject<Fundamentals, Never>
    private let fundamentalsBackgroundJobSubmission: BackgroundJobSubmission<Fundamentals>
    private var storage = Set<AnyCancellable>()
    
    init(symbol: String) {
        self.symbol = symbol
        
        let fundamentalsLoader = Future<Fundamentals, Never> { promise in
            DispatchQueue.global(qos: .userInitiated).async {
                var fundamentals: Fundamentals
                do {
                    fundamentals = try FundamentalsController().getFundamentals(forSymbol: symbol)
                } catch {
                    fundamentals = .empty
                }
                promise(.success(fundamentals))
            }
        }
        
        // Init publisher
        fundamentalsPublisher = CurrentValueSubject<Fundamentals, Never>(.empty)
        fundamentalsBackgroundJobSubmission = BackgroundJobSumitter.submit(jobConfiguration: FundamentalsBackgroundJob(symbol: symbol))
        fundamentalsBackgroundJobSubmission.publisher
            .append(fundamentalsLoader)
            .sink { self.fundamentalsPublisher.send($0) }
            .store(in: &storage)
        
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
            popover.contentViewController = NSHostingController(rootView: LiveQuotePopoverView(fundamentalsViewModel: FundamentalsViewModel(fundamentalsPublisher: fundamentalsPublisher)))
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }
    
    func remove() {
        fundamentalsBackgroundJobSubmission.cancelJob()
        NSStatusBar.system.removeStatusItem(statusItem)
    }
}
