//
//  Ticker.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/26/20.
//

import Alamofire

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
        
        guard let value = data else {
            return nil
        }
        
        return transformer(value)
    }
}

class Ticker {
    private let ticker: String
    private static let BASE_URL: String = "https://query1.finance.yahoo.com/v8/finance/"
    
    init(ticker: String) {
        self.ticker = ticker
    }
    
    func getLiveQuote(callback: @escaping (Response<Quote>) -> Void) {
//        AF.request(Ticker.BASE_URL).validate().responseDecodable { (response: DataResponse<ChartWrapper, AFError>) in
//            var finalResponse: Response<Quote> = Response()
//            
//            defer { callback(finalResponse) }
//            do {
//                try finalResponse.data = Quote(price: response.result.get().chart.result[0].meta.regularMarketPrice)
//            } catch is AFError {
//                finalResponse.error = error
//            }
//        }
    }
}

struct ChartWrapper: Codable {
    let chart: MetaWrapper
    
    struct MetaWrapper: Codable {
        let result: [LiveQuoteResponseWrapper]
        
        struct LiveQuoteResponseWrapper: Codable {
            let meta: LiveQuoteResponse
            
            struct LiveQuoteResponse: Codable {
                let regularMarketPrice: Double
            }
        }
    }
}


struct Quote {
    var price: Double
}
