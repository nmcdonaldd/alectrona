//
//  ETFFundamentalsView.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/27/21.
//

import SwiftUI

struct ETFFundamentalsView: View {
    var fundamentals: ETFFundamentals
    var body: some View {
        VStack(alignment: .leading) {
            TitleWithExchange(title: fundamentals.longName, exchangeName: fundamentals.fullExchangeName)
            HStack {
                FundamentalDataList(fundamentalData: buildFirstDataList(from: fundamentals))
                SpacedDivider()
                FundamentalDataList(fundamentalData: buildSecondDataList(from: fundamentals))
            }.fixedSize()
        }.fixedSize()
    }
    
    private func buildFirstDataList(from fundamentals: ETFFundamentals) -> [FundamentalDataList.RowItem] {
        return [
            FundamentalDataList.RowItem(label: "Market Cap", value: String(describing: fundamentals.marketCap.formatUsingAbbrevation())),
            FundamentalDataList.RowItem(label: "Open", value: String(describing: fundamentals.regularMarketOpen.rounded(toPlaces: 2))),
            FundamentalDataList.RowItem(label: "Bid", value: "\(fundamentals.bid) x \(fundamentals.bidSize*100)"),
            FundamentalDataList.RowItem(label: "Ask", value: "\(fundamentals.ask) x \(fundamentals.askSize*100)"),
            FundamentalDataList.RowItem(label: "Day's Range", value: fundamentals.regularMarketDayRange),
            FundamentalDataList.RowItem(label: "52 Week Range", value: fundamentals.fiftyTwoWeekRange)
        ]
    }
    
    private func buildSecondDataList(from fundamentals: ETFFundamentals) -> [FundamentalDataList.RowItem] {
        return [
            FundamentalDataList.RowItem(label: "Previous Close", value: String(describing: fundamentals.regularMarketPreviousClose)),
            FundamentalDataList.RowItem(label: "Volume", value: String(describing: fundamentals.regularMarketVolume.formatUsingAbbrevation())),
            FundamentalDataList.RowItem(label: "PE Ratio", value: valueAsStringOrNotAvailable(fundamentals.trailingPE?.rounded(toPlaces: 2))),
            FundamentalDataList.RowItem(label: "Something", value: "FIXME"),
            FundamentalDataList.RowItem(label: "Something Else", value: "FIXME"),
//            FundamentalDataList.RowItem(label: "EPS Ratio", value: valueAsStringOrNotAvailable(fundamentals.epsTrailingTwelveMonths?.rounded(toPlaces: 2))),
//            FundamentalDataList.RowItem(label: "Earnings Date", value: "\(valueAsStringOrNotAvailable(fundamentals.earningsTimestamp)) - FIXME!"),
            FundamentalDataList.RowItem(label: "52 Week Range", value: fundamentals.fiftyTwoWeekRange)
        ]
    }
    
    private func valueAsStringOrNotAvailable<T>(_ value: T?) -> String {
        if let nonNullValue = value {
            return String(describing: nonNullValue)
        }
        return "N/A"
    }
}

//struct ETFFundamentalsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ETFFundamentalsView()
//    }
//}
