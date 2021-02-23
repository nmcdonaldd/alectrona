//
//  AppDelegate.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/15/20.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusBar: StatusBar?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusBar = StatusBar()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
