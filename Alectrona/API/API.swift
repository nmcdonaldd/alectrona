//
//  Ticker.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/26/20.
//

import Alamofire
import SwiftyJSON
/// FIXME: remove combine from API
import Combine

struct Response<T> {
    struct ErrorInReponse: Error {
        var message: String
    }
    
    var error: Error?
    var data: T?
    func map<OTHER>(_ transformer: (T) -> OTHER?) -> OTHER? {
        guard error == nil else {
            return nil
        }
        
        guard let guaranteedData = data else {
            return nil
        }
        
        return transformer(guaranteedData)
    }
}

class API {
    private static let BASE_URL: String = "https://query1.finance.yahoo.com/v8/finance/chart/"
    
    class func getLiveQuote(forTicker ticker: String, callback: @escaping (Response<Quote>) -> Void) {
        AF.request(API.BASE_URL + ticker).validate().responseJSON { (response) in
            guard let data = response.data else {
                return
            }
            
            var callbackResponse: Response<Quote> = Response()
            defer { callback(callbackResponse) }
            
            do {
                let asJSON = try JSON(data: data)
                let jsonPrice = asJSON["chart"]["result"][0]["meta"]["regularMarketPrice"].number ?? 0.0
                let jsonPreviousClose = asJSON["chart"]["result"][0]["meta"]["previousClose"].number ?? 0.0
                callbackResponse.data = Quote(price: Double(truncating: jsonPrice), previousClose: Double(truncating: jsonPreviousClose))
            } catch {
                callbackResponse.error = error
            }
        }
    }
    
    class func searchTickers2(_ searchText: String) -> AnyPublisher<[TickerSearchResult], URLSession.DataTaskPublisher.Failure> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "query1.finance.yahoo.com"
        components.path = "/v1/finance/search"
        components.queryItems = [
            URLQueryItem(name: "q", value: searchText)
        ]
        
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.data }
            .map { (data) -> [TickerSearchResult] in
                do {
                    let asJSON = try JSON(data: data)
                    return asJSON["quotes"].arrayValue
                        .map { TickerSearchResult(symbol: $0["symbol"].stringValue, name: $0["longname"].stringValue, exchange: $0["exchange"].stringValue) }
                } catch {
                    return [TickerSearchResult]()
                }
            }
            .eraseToAnyPublisher()
    }
}

struct TickerSearchResult {
    var symbol: String
    var name: String
    var exchange: String
}

struct Quote {
    var price: Double
    var previousClose: Double
}
