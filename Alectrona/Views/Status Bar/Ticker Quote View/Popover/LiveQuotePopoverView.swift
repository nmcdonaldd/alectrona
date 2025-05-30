//
//  LiveQuotePopoverView.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/7/21.
//

import Foundation
import SwiftUI
import Combine

struct LiveQuotePopoverView: View {
    
    @ObservedObject var fundamentalsViewModel: FundamentalsViewModel
    
    var fundamentalsAndPossiblyNews: some View {
        VStack {
//            Text("Fundamentals")
//                .font(.body)
//                .bold()
//                .interfaceStyleRespectingGray()
            CombinedFundamentals(fundamentals: fundamentalsViewModel.fundamentals)
            if(Features.newsStreaming) {
                Divider()
                Text("News")
                    .font(.body)
                    .bold()
                    .interfaceStyleRespectingGray()
                NewsList(newsList: fundamentalsViewModel.news)
            }
        }.padding()
    }
    
    var body: some View {
        if(Features.newsStreaming) {
            ScrollView {
                fundamentalsAndPossiblyNews
            }
        } else {
            fundamentalsAndPossiblyNews
        }
    }
}

struct LiveQuotePopoverView_Preview: PreviewProvider {
    static var previews: some View {
        LiveQuotePopoverView(fundamentalsViewModel: FundamentalsViewModel(fundamentalsPublisher: Just(.empty).eraseToAnyPublisher(), newsPublisher: Just([News]()).eraseToAnyPublisher()))
    }
}
