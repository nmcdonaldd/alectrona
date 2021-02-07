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
                NewsRow(news: news)
            }
        }
    }
}
