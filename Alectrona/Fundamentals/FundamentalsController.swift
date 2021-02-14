//
//  FundamentalsController.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/12/21.
//

import Foundation
import Combine
import Resolver

class FundamentalsController {
    
    @Injected private var htmlScraper: HTMLScraper
    
    struct FundamentalsControllerError: Error {}
    
    func getFundamentals(forSymbol symbol: String) -> AnyPublisher<Fundamentals, Never> {
        return Future<Fundamentals, Never> { promise in
            DispatchQueue.global(qos: .utility).async {
                do {
                    let documentToScrape = try self.htmlScraper.getDocument(fromURL: self.getFundamentalsURL(forSymbol: symbol))
                    
                    guard let document = documentToScrape else {
                        throw FundamentalsControllerError()
                    }
                    
                    let rawFundamentalsData = try FundamentalsScraper.shared.getFundamentals(fromDocument: document)
                    
                    promise(.success(Fundamentals(
                        marketCap: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.marketCap]!,
                        open: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.open]!,
                        bid: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.bid]!,
                        ask: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.ask]!,
                        daysRange: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.daysRange]!,
                        fiftyTwoWeekRange: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.fiftyTwoWeekRange]!,
                        todayVolume: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.todayVolume]!,
                        threeMonthAverageVolume: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.threeMonthAverageVolume]!,
                        fiveYearBeta: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.fiveYearBeta]!,
                        peRatio: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.peReatio]!,
                        epsRatio: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.epsRatio]!,
                        earningsDate: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.earningsDate]!,
                        dividendAndYield: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.dividendAndYield]!,
                        exDividendDate: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.exDividendDate]!,
                        oneYearPriceTarget: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.oneYearTargetPrice]!,
                        previousClose: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.previousClose]!)))
                } catch {
                    // FIXME: Don't just replace with an empty Fundamentals handle with a real error.
                    promise(.success(.empty))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private func getFundamentalsURL(forSymbol symbol: String) -> URL {
        // FIXME: move to URL components composition?
        return URL(string: "https://finance.yahoo.com/quote/\(symbol)")!
    }
}
