//
//  FundamentalsController.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/12/21.
//

import Foundation

class FundamentalsController {
    
    struct FundamentalsControllerError: Error {}
    
    func getFundamentalsForSymbol(_ symbol: String) throws -> Fundamentals {
        let documentToScrape = try HTMLScraper.getDocument(fromURL: getFundamentalsURL(forSymbol: symbol))
        
        guard let document = documentToScrape else {
            throw FundamentalsControllerError()
        }
        
        let rawFundamentalsData = try FundamentalsScraper.shared.getFundamentals(fromDocument: document)
        
        return Fundamentals(
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
            previousClose: rawFundamentalsData[YFinanceHTMLKey.Fundamentals.previousClose]!)
    }
    
    private func getFundamentalsURL(forSymbol symbol: String) -> URL {
        // FIXME: move to URL components composition?
        return URL(string: "https://finance.yahoo.com/quote/\(symbol)")!
    }
}
