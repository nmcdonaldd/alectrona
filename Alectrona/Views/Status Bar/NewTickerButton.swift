//
//  NewTickerButton.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/29/20.
//

import Foundation
import SwiftUI

class NewTickerButton {
    private var statusBarItem: StatusBarItem
    
    init() {
        statusBarItem = StatusBarItemBuilder()
            .view(NewTickerStatusItemView())
            .popoverView(NewTickerSelectorView())
            .build()
    }
}
