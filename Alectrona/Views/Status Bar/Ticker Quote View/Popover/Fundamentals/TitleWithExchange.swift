//
//  TitleWithExchange.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 3/11/21.
//

import SwiftUI

struct TitleWithExchange: View {
    var title: String
    var exchangeName: String
    var body: some View {
        HStack {
            FundamentalsTitle(title: title)
            Spacer()
            ExchangeTitle(exchangeName: exchangeName)
        }
    }
}

struct TitleWithExchange_Previews: PreviewProvider {
    static var previews: some View {
        TitleWithExchange(title: "AAPL", exchangeName: "NasdaqGS")
    }
}
