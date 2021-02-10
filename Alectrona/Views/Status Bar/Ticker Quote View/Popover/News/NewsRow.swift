//
//  NewsRow.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/5/21.
//

import Foundation
import SwiftUI

struct NewsRow: View {
    var news: News
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(news.title)
                .font(.headline)
                .bold()
            Spacer(minLength: 2)
            HStack(spacing: 2) {
                Text(news.publisher)
                Text("•")
                Text(String(news.publishedTime))
            }
            .font(.subheadline)
            .foregroundColor(.gray)
            Spacer(minLength: 4)
            Text(news.newsText[0])
                .font(.body)
        }
    }
}

#if DEBUG
struct NewsRow_PreviewProvider: PreviewProvider {
    static var previews: some View {
        NewsRow(news: News(publishedTime: 1612440180, title: "Veeva Systems (VEEV) Outpaces Stock Market Gains: What You Should Know", newsText: ["Veeva Systems (VEEV) closed at $290 in the latest trading session, marking a +1.38% move from the prior day. The stock outpaced the S&P 500's daily gain of 1.09%. Meanwhile, the Dow gained 1.08%, and the Nasdaq, a tech-heavy index, added 1.23%.", "Investors will be hoping for strength from VEEV as it approaches its next earnings release. The company is expected to report EPS of $0.68, up 25.93% from the prior-year quarter. Meanwhile, our latest consensus estimate is calling for revenue of $379.88 million, up 21.95% from the prior-year quarter.", "Any recent changes to analyst estimates for VEEV should also be noted by investors. These recent revisions tend to reflect the evolving nature of short-term business trends. As a result, we can interpret positive estimate revisions as a good sign for the company's business outlook."], publisher: "Zacks", url: "https://finance.yahoo.com/news/veeva-systems-veev-outpaces-stock-225010578.html"))
    }
}
#endif
