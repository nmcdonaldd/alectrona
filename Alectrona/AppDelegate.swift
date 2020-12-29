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
        quoteRunner.delegate = LiveQuoteStore.shared
        quoteRunner.beginRepeatedWork()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

