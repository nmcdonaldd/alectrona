//
//  ExampleView.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/29/20.
//

import Foundation
import SwiftUI

struct NewTickerSelectorView: View {
    @State var input: String = ""
    @ObservedObject var model = TickerSearchModel()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Ticker", text: $model.searchText)
            }
            TickerList(tickerList: model.searchResults)
                .background(Color.clear)
        }.padding()
    }
}

struct NewTickerSelector_Previews: PreviewProvider {
    
    static var previews: some View {
        NewTickerSelectorView()
    }
}
