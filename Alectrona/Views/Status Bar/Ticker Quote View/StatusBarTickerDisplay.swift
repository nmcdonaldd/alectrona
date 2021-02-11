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
    
    @ObservedObject var liveQuote: LiveQuote
    
    var formattedQuote: String {
        /// FIXME: is .currency localized? Would it be correct if user in another language? I doubt it. Perhaps remove $ (implicitly added with .currency)
        NumberFormatter.localizedString(from: NSNumber(value: liveQuote.currentQuote.regularMarketPrice), number: .currency)
    }
    
    var formattedPercentageDifference: String {
        String(format: "%.2f", liveQuote.currentQuote.percentageGain*100.0)
//        NumberFormatter.localizedString(from: NSNumber(value: (liveQuote.currentQuote.percentageGain*100).rounded(toPlaces: 2)), number: .decimal)
    }
    
    var color: Color {
        if(liveQuote.currentQuote.percentageGain < 0) {
            return .red
        }
        
        return .green
    }
    
    var body: some View {
        StatusItemViewable(onSizeChange: onSizeChange) {
            HStack(spacing: 6) {
                Text(ticker)
                    .bold()
                    .foregroundColor(.primary)
                Text(formattedQuote)
                    .foregroundColor(.primary)
                Text("(\(formattedPercentageDifference)%)")
                    .foregroundColor(color)
            }.fixedSize()
        }
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
