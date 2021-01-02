//
//  StatusBarTickerDisplay.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/24/20.
//

import SwiftUI

private struct StatusBarPreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = CGSize.zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
    
    typealias Value = CGSize
}

struct StatusBarTickerDisplay: View {
    var ticker: String
    var onSizeChange: (CGSize) -> Void
    
    @EnvironmentObject var quote: LiveQuote
    
    var formattedQuote: String {
        NumberFormatter.localizedString(from: NSNumber(value: quote.fairMarketPrice), number: .currency)
    }
    
    var formattedPercentageDifference: String {
        NumberFormatter.localizedString(from: NSNumber(value: (quote.percentageGain*100).rounded(toPlaces: 2)), number: .decimal)
    }
    
    var body: some View {
        HStack(spacing: 6) {
            Text(ticker)
                .bold()
                .foregroundColor(.primary)
            Text(formattedQuote)
                .foregroundColor(.primary)
            Text("(\(formattedPercentageDifference)%)")
                .foregroundColor(quote.percentageGain == 0.0 ? .white : quote.percentageGain < 0 ? .red : .green)
        }.fixedSize()
        .background(GeometryReader { proxy in
            return Color.clear.preference(key: StatusBarPreferenceKey.self, value: proxy.size)
        }).onPreferenceChange(StatusBarPreferenceKey.self, perform: { value in
            DispatchQueue.main.async {
                onSizeChange(value)
            }
        })
    }
}

#if DEBUG
struct StatusBarTickerDisplay_Previews: PreviewProvider {
    static var veevQuote: LiveQuote {
        let liveQuote = LiveQuote()
        liveQuote.fairMarketPrice = 256.123
        liveQuote.percentageGain = 0.012
        return liveQuote
    }
    
    static var cscoQuote: LiveQuote {
        let liveQuote = LiveQuote()
        liveQuote.fairMarketPrice = 44.12
        liveQuote.percentageGain = -0.012
        return liveQuote
    }
    
    static var previews: some View {
        HStack(spacing: 12) {
            StatusBarTickerDisplay(ticker: "VEEV") { (_) in
                // No-op
            }.environmentObject(veevQuote)
            StatusBarTickerDisplay(ticker: "CSCO") { (_) in
                // No-op
            }.environmentObject(cscoQuote)
        }
    }
}
#endif
