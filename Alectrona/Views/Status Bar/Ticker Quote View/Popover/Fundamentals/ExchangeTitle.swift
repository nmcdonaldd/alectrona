//
//  ExchangeTitle.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 3/11/21.
//

import SwiftUI

struct ExchangeTitle: View {
    var exchangeName: String
    var body: some View {
        Text(exchangeName)
            .font(.body)
            .interfaceStyleRespectingGray()
    }
}

struct ExchangeTitle_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeTitle(exchangeName: "NasdaqGS")
    }
}
