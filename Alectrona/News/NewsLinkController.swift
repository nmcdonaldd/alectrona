//
//  NewsLinkController.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/6/21.
//

import Foundation
import Combine

class NewsLinkController {
    
    private struct NewsSearchResult: Decodable {
        var news: [NewsLink]
    }
    
    func getNewsLinks(forSymbol symbol: String, newsCount: Int = 3) -> AnyPublisher<[NewsLink], Error> {
        let endpoint = Endpoint.getNews(forSymbol: symbol, newsCount: newsCount)
        return API.get(type: NewsSearchResult.self, url: endpoint.url)
            .map({ $0.news })
            .eraseToAnyPublisher()
    }
}
