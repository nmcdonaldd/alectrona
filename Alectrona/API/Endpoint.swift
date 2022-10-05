//
//  Endpoint.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/1/21.
//

import Foundation

struct Endpoint {
    var host: String
    var path: String = ""
    var queryItems: [URLQueryItem]?
    var scheme = "https"
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
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
    
    private static let YFINANCE_HOST = "query1.finance.yahoo.com"
    
    static func standardYFinanceHost(path: String, queryItems: [URLQueryItem]?) -> Self {
        if let guarnteedQueryItems = queryItems {
            return Endpoint(host: YFINANCE_HOST, path: path, queryItems: guarnteedQueryItems)
        } else {
            return Endpoint(host: YFINANCE_HOST, path: path)
        }
    }
    
    static func tickerSearch(_ searchText: String?) -> Self {
        return standardYFinanceHost(
            path: "/v1/finance/search",
            queryItems: [URLQueryItem(name: "q", value: searchText)])
    }
    
    static func getQuote(forSymbol symbol: String) -> Self {
        return standardYFinanceHost(path: "/v8/finance/chart/\(symbol)", queryItems: nil)
    }
    
    static func getNews(forSymbol symbol: String, newsCount: Int = 3) -> Self {
        return standardYFinanceHost(
            path: "/v1/finance/search",
            queryItems: [
                URLQueryItem(name: "q", value: symbol),
                URLQueryItem(name: "newsCount", value: String(newsCount))
            ])
    }
    
    static func getFundamentals(forSymbol symbol: String, requestedFields: [String]) -> Self {
        return standardYFinanceHost(
            path: "/v7/finance/quote",
            queryItems: [
                URLQueryItem(name: "symbols", value: symbol),
                URLQueryItem(name: "fields", value: requestedFields.joined(separator:","))
            ])
    }
    
    static func streamQuote() -> Self {
        return Endpoint(host: "streamer.finance.yahoo.com", scheme: "wss")
    }
}
