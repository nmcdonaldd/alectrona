//
//  CombinedFundamentals.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/9/21.
//

import SwiftUI

struct CombinedFundamentals: View {
    var fundamentals: FundamentalsQuoteTypeResponse
    var body: some View {
        switch fundamentals {
        case .equity(let equityFundamentals):
            return AnyView(EquityFundamentalsView(equityFundamentals: equityFundamentals))
        case .etf(let etfFundamentals):
            return AnyView(ETFFundamentalsView(fundamentals: etfFundamentals))
        case .cryptocurrency(let cryptocurrencyFundamentals):
            return AnyView(CryptocurrencyFundamentalsView(cryptocurrencyFundamentals: cryptocurrencyFundamentals))
        case .empty:
            return AnyView(Text("Loading..."))
        }
    }
//        HStack {
//            FundamentalDataList(fundamentalData: buildFundamentalDataListColumn1(from: fundamentals))
//            Spacer(minLength: Spacing.medium)
//            Divider()
//            Spacer(minLength: Spacing.medium)
//            FundamentalDataList(fundamentalData: buildFundamentalDataListColumn2(from: fundamentals))
//        }.fixedSize()
//    }
    
//    private func buildFundamentalDataListColumn1(from fundamentals: FundamentalsQuoteTypeResponse) -> [FundamentalDataList.FundamentalDataRow] {
//        switch fundamentals {
//        case .equity(let equityFundamentals):
//            return [
//                FundamentalDataList.FundamentalDataRow(label: "Market Cap", value: String(describing: equityFundamentals.marketCap))
//            ]
//        case .cryptocurrency(let cryptocurrencyFundamentals):
//            return [
//                FundamentalDataList.FundamentalDataRow(label: "Market Cap", value: String(describing: cryptocurrencyFundamentals.marketCap))
//            ]
//        default: return [FundamentalDataList.FundamentalDataRow(label: "Loading...", value: "")]
//        }
//    }
//
//    private func buildFundamentalDataListColumn2(from fundamentals: FundamentalsQuoteTypeResponse) -> [FundamentalDataList.FundamentalDataRow] {
//        switch fundamentals {
//        case .equity(let equityFundamentals): return [
//            FundamentalDataList.FundamentalDataRow(label: "Bid", value: String(describing: equityFundamentals.bid))
//        ]
//        case .cryptocurrency(let cryptocurrencyFundamentals): return [
//            FundamentalDataList.FundamentalDataRow(label: "Open", value: String(describing: cryptocurrencyFundamentals.regularMarketOpen))
//        ]
//        default: return [FundamentalDataList.FundamentalDataRow(label: "Loading...", value: "")]
//        }
//    }
}

struct CombinedFundamentals_Previews: PreviewProvider {
    static var previews: some View {
        CombinedFundamentals(fundamentals: .empty)
    }
}
