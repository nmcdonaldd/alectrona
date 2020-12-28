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
    let quoteRunner = LiveQuoteRunner()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        refreshLiveQuotes(for: getLiveQuotes())
//        statusBar.updateStatusBarTickers(tickerDatum: [StatusBarTickerData(ticker: "AMZN", quote: 3172.69, percentageDifference: -0.02981), StatusBarTickerData(ticker: "VEEV", quote: 285.12123, percentageDifference: 55.53512)])
        quoteRunner.beginRepeatedWork()
    }
    
    func getLiveQuotes() -> [String]{
        return ["AAPL", "VEEV"]
    }
    
//    func refreshLiveQuotes(for symbols: [String]) {
//        let tickers = symbols.map({ Ticker(ticker: $0) })
//        TickerManager.getLiveQuotes(for: tickers) { [weak self] (data) in
//            guard let strongSelf = self else {
//                return
//            }
//
//            strongSelf.statusBar.updateStatusBarTickers(tickerDatum: [StatusBarTickerData(ticker: "AMZN", quote: 3172.69, percentageDifference: -0.02981), StatusBarTickerData(ticker: "VEEV", quote: 285.12123, percentageDifference: 55.53512)])
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
//                guard let strongSelf = self else {
//                    return
//                }
//                strongSelf.refreshLiveQuotes(for: strongSelf.getLiveQuotes())
//            }
//        }
//    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

