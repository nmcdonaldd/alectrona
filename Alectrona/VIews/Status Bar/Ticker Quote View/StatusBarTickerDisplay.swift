//
//  StatusBarTickerDisplay.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/24/20.
//

import SwiftUI

struct StatusBarTickerDisplay: View {
    let ticker: String
    let onSizeChange: (CGSize) -> Void
    
    @ObservedObject var liveQuote: LiveQuote
    
    var formattedQuote: String {
        NumberFormatter.localizedString(from: NSNumber(value: liveQuote.regularMarketPrice), number: .currency)
    }
    
    var formattedPercentageDifference: String {
        NumberFormatter.localizedString(from: NSNumber(value: (liveQuote.percentageGain*100).rounded(toPlaces: 2)), number: .decimal)
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
                    .foregroundColor(liveQuote.percentageGain == 0.0 ? .white : liveQuote.percentageGain < 0 ? .red : .green)
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
