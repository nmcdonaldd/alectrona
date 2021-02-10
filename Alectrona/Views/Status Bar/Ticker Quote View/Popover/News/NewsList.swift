//
//  NewsList.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/5/21.
//

import Foundation
import SwiftUI

struct NewsList: View {
    var newsList: [News]
    
    var body: some View {
        VStack {
            ForEach(newsList, id: \.url) { news in
                Button(action: {
                    if let url = URL(string: news.url) {
                        NSWorkspace.shared.open(url)
                    }
                }, label: {
                    NewsRow(news: news)
                }).buttonStyle(PlainButtonStyle())
                Divider()
            }
        }
    }
}
