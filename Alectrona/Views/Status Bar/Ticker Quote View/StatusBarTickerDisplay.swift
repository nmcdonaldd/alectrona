//
//  StatusBarTickerDisplay.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/24/20.
//

import Foundation
import SwiftUI

struct StatusBarTickerDisplay: View {
    let ticker: String
    let onSizeChange: (CGSize) -> Void
    
    /// FIXME: this should be stateobject but I can't figure out how to do a customized init
    @ObservedObject private var liveQuote: LiveQuote
    
    var formattedQuote: String {
        /// FIXME: is .currency localized? Would it be correct if user in another language? I doubt it. Perhaps remove $ (implicitly added with .currency)
        NumberFormatter.localizedString(from: NSNumber(value: liveQuote.currentQuote.regularMarketPrice), number: .currency)
    }
    
    var formattedPercentageDifference: String {
        String(format: "%.2f", liveQuote.currentQuote.percentageGain*100.0)
    }
    
    var color: Color {
        if(liveQuote.currentQuote.percentageGain < 0) {
            return .red
        }
        
        // We'll return .green if the percentage is net-zero, why not?
        return .green
    }
    
    var body: some View {
        HStack(spacing: 6) {
            Text(ticker)
                .bold()
                .foregroundColor(.primary)
            Text(formattedQuote)
                .foregroundColor(.primary)
            Text("(\(formattedPercentageDifference)%)")
                .foregroundColor(color)
        }.fixedSize()
        .inStatusBar(onSizeChange: onSizeChange)
    }
    
    init(symbol: String, onSizeChange: @escaping (CGSize) -> Void) {
        self.ticker = symbol
        self.onSizeChange = onSizeChange
        liveQuote = LiveQuote(symbol: symbol)
    }
}

//#if DEBUG
//struct StatusBarTickerDisplay_Previews: PreviewProvider {
//    static var veevQuote: LiveQuote {
//        let liveQuote = LiveQuote()
//        liveQuote.fairMarketPrice = 256.123
//        liveQuote.percentageGain = 0.012
//        return liveQuote
//    }
//
//    static var cscoQuote: LiveQuote {
//        let liveQuote = LiveQuote()
//        liveQuote.fairMarketPrice = 44.12
//        liveQuote.percentageGain = -0.012
//        return liveQuote
//    }
//
//    static var previews: some View {
//        HStack(spacing: 12) {
//            StatusBarTickerDisplay(ticker: "VEEV") { (_) in
//                // No-op
//            }.environmentObject(veevQuote)
//            StatusBarTickerDisplay(ticker: "CSCO") { (_) in
//                // No-op
//            }.environmentObject(cscoQuote)
//        }
//    }
//}
//#endif
