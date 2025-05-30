//
//  TickerController.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/1/21.
//

import Foundation
import Combine
import Factory

class TickerController {
    
    @Injected(Container.api) private var api: API
    
    private struct TickerSearchResult: Decodable {
        var quotes: [Ticker]
    }
    
    func searchTickers(withText text: String) -> AnyPublisher<[Ticker], Error> {
        let endpoint = Endpoint.tickerSearch(text)
        return api.get(type: TickerSearchResult.self, url: endpoint.url)
            .map(\.quotes)
            .eraseToAnyPublisher()
    }
}
