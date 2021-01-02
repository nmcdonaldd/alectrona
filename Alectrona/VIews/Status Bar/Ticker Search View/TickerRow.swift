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
            print("clicked!")
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
