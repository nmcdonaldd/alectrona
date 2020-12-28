//
//  Ticker.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/26/20.
//

import Alamofire
import SwiftyJSON

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

class QuoteLoader {
    private static let BASE_URL: String = "https://query1.finance.yahoo.com/v8/finance/chart/"
    
    class func getLiveQuote(forTicker ticker: String, callback: @escaping (Response<Quote>) -> Void) {
        AF.request(QuoteLoader.BASE_URL + ticker).validate().responseJSON { (response) in
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
}

struct Quote {
    var price: Double
    var previousClose: Double
}
