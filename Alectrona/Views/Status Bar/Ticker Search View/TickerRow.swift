//
//  TickerRow.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/1/21.
//

import Foundation
import SwiftUI

struct TickerRow: View {
    var ticker: Ticker
    
    var body: some View {
        Button(action: {
            var currentValues = UserDefaultsHelper.getValue(forKey: UserDefaultsKey.watchlist, withDefaultValue: [String]())!   // Safe since we are providing a non-nil default value
            currentValues.append(ticker.symbol)
            UserDefaultsHelper.setValue(forKey: UserDefaultsKey.watchlist, value: currentValues)
            NotificationCenter.default.post(name: NotificationKey.newTickerAdded, object: nil)
        }, label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(ticker.symbol)
                        .font(.title3)
                    if (ticker.longname != nil) {
                        Text(ticker.longname!)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                }
                Spacer()
                Text(ticker.exchange)
                    .font(.subheadline)
            }
        }).buttonStyle(PlainButtonStyle())
    }
}

//#if DEBUG
//struct TickerRow_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            TickerRow(ticker: TickerSearchResult(symbol: "VEEV", name: "Veeva Systems, Inc.", exchange: "NYS"))
//            TickerRow(ticker: TickerSearchResult(symbol: "CSCO", name: "Cisco Systems", exchange: "NYSE"))
//        }.previewLayout(.fixed(width: 1000, height: 1000))
//    }
//}
//#endif
