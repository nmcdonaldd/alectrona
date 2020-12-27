//
//  AppDelegate.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/15/20.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusBar = StatusBar()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBar.updateStatusBarTickers(tickerDatum: [StatusBarTickerData(ticker: "AMZN", quote: 3172.69, percentageDifference: -0.02981), StatusBarTickerData(ticker: "VEEV", quote: 285.12123, percentageDifference: 0.053512)])
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

