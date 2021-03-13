//
//  EquityFundamentals.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/26/21.
//

import SwiftUI

struct EquityFundamentalsView: View {
    var equityFundamentals: EquityFundamentals
    var body: some View {
        VStack(alignment: .leading) {
            TitleWithExchange(title: equityFundamentals.longName, exchangeName: equityFundamentals.fullExchangeName)
            HStack {
                FundamentalDataList(fundamentalData: buildFirstDataList(from: equityFundamentals))
                SpacedDivider()
                FundamentalDataList(fundamentalData: buildSecondDataList(from: equityFundamentals))
            }.fixedSize()
        }.fixedSize()
    }
    
    private func buildFirstDataList(from fundamentals: EquityFundamentals) -> [FundamentalDataList.RowItem] {
        return [
            FundamentalDataList.RowItem(label: "Market Cap", value: String(describing: fundamentals.marketCap.formatUsingAbbrevation())),
            FundamentalDataList.RowItem(label: "Open", value: String(describing: fundamentals.regularMarketOpen.rounded(toPlaces: 2))),
            FundamentalDataList.RowItem(label: "Bid", value: "\(fundamentals.bid) x \(fundamentals.bidSize*100)"),
            FundamentalDataList.RowItem(label: "Ask", value: "\(fundamentals.ask) x \(fundamentals.askSize*100)"),
            FundamentalDataList.RowItem(label: "Day's Range", value: fundamentals.regularMarketDayRange),
            FundamentalDataList.RowItem(label: "52 Week Range", value: fundamentals.fiftyTwoWeekRange)
        ]
    }
    
    private func buildSecondDataList(from fundamentals: EquityFundamentals) -> [FundamentalDataList.RowItem] {
        return [
            FundamentalDataList.RowItem(label: "Previous Close", value: String(describing: fundamentals.regularMarketPreviousClose)),
            FundamentalDataList.RowItem(label: "Volume", value: String(describing: fundamentals.regularMarketVolume.formatUsingAbbrevation())),
            FundamentalDataList.RowItem(label: "PE Ratio", value: valueAsStringOrNotAvailable(fundamentals.trailingPE?.rounded(toPlaces: 2))),
            FundamentalDataList.RowItem(label: "EPS Ratio", value: valueAsStringOrNotAvailable(fundamentals.epsTrailingTwelveMonths?.rounded(toPlaces: 2))),
            FundamentalDataList.RowItem(label: "Earnings Date", value: "\(valueAsStringOrNotAvailable(formatDateFromEpoch(fundamentals.earningsTimestampStart))) - \(valueAsStringOrNotAvailable(formatDateFromEpoch(fundamentals.earningsTimestampEnd)))"),
            FundamentalDataList.RowItem(label: "52 Week Range", value: fundamentals.fiftyTwoWeekRange)
        ]
    }
    
    private func formatDateFromEpoch(_ timeSince1970: Int?) -> String? {
        guard let time = timeSince1970 else {
            return nil
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
        return dateFormatter.string(from: date)
    }
    
    private func valueAsStringOrNotAvailable<T>(_ value: T?) -> String {
        if let nonNullValue = value {
            return String(describing: nonNullValue)
        }
        return "N/A"
    }
}

//struct EquityFundamentalsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EquityFundamentalView()
//    }
//}
