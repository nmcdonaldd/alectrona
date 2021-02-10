//
//  TickerList.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/1/21.
//

import Foundation
import SwiftUI

struct TickerList: View {
    var tickerList: [Ticker]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(tickerList, id: \.symbol) { ticker in
                    TickerRow(ticker: ticker)
                    Divider()
                }
            }
        }
    }
}

//#if DEBUG
//struct TickerList_Preview: PreviewProvider {
//    static var previews: some View {
//        TickerList(tickerList: [TickerSearchResult(symbol: "CSCO", name: "Cisco Systems, Inc", exchange: "NYQ"), TickerSearchResult(symbol: "SPY", name: "SPDR Standards & Poor Deposits", exchange: "NYSE")])
//            .previewLayout(.sizeThatFits)
//    }
//}
//#endif
