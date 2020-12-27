//
//  StatusBarTickerDisplay.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/24/20.
//

import SwiftUI

struct StatusBarPreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = CGSize.zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
    
    typealias Value = CGSize
}

struct TickerSize {
    var size: CGSize
    var ticker: String
}

struct StatusBarTickerDisplay: View {
    var onSizeChange: (TickerSize) -> Void
    var data: StatusBarTickerData
    
    var formattedQuote: String {
        NumberFormatter.localizedString(from: NSNumber(value: data.quote), number: .currency)
    }
    
    var formattedPercentageDifference: String {
        NumberFormatter.localizedString(from: NSNumber(value: (data.percentageDifference*100.0).rounded(toPlaces: 2)), number: .decimal)
    }
    
    var body: some View {
        HStack(spacing: 6) {
            Text(data.ticker)
                .bold()
                .foregroundColor(.primary)
            Text(formattedQuote)
                .foregroundColor(.primary)
            Text("(\(formattedPercentageDifference)%)")
                .foregroundColor(data.percentageDifference == 0.0 ? .black : data.percentageDifference < 0 ? .red : .green)
        }.background(GeometryReader { proxy in
            return Color.clear.preference(key: StatusBarPreferenceKey.self, value: proxy.size)
        }).onPreferenceChange(StatusBarPreferenceKey.self, perform: { value in
            DispatchQueue.main.async {
                onSizeChange(TickerSize(size: value, ticker: data.ticker))
            }
        })
    }
}

struct StatusBarTickerDisplay_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 12) {
            StatusBarTickerDisplay(onSizeChange: { (_) in
                // No op
            }, data: StatusBarTickerData(ticker: "AAPL", quote: 131.97, percentageDifference: 0.012))
            StatusBarTickerDisplay(onSizeChange: { (_) in
                // No op
            }, data: StatusBarTickerData(ticker: "AMZN", quote: 3123.12834, percentageDifference: -0.123))
        }
    }
}
