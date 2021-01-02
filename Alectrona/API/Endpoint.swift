//
//  Endpoint.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/1/21.
//

import Foundation

struct Endpoint {
    var path: String
    var host: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

extension Endpoint {
    static func tickerSearch(_ searchText: String?) -> Self {
        return Endpoint(path: "/v1/finance/search",
                        host: "query1.finance.yahoo.com",
                        queryItems: [URLQueryItem(name: "q", value: searchText)])
    }
    
    static func getQuote(forSymbol symbol: String) -> Self {
        return Endpoint(path: "/v8/finance/chart/\(symbol)", host: "query1.finance.yahoo.com")
    }
}
