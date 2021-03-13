//
//  NewTickerStatusItem.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/8/21.
//

import Foundation
import SwiftUI

struct NewTickerStatusItemView: View {
    var onSizeChange: (CGSize) -> Void
    
    var body: some View {
        Image(systemName: "plus")
            .inStatusBar(onSizeChange: onSizeChange)
    }
}
