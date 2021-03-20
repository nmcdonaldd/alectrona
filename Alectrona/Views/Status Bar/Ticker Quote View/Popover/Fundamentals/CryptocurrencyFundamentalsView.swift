//
//  CryptocurrencyFundamentals.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/26/21.
//

import SwiftUI

struct CryptocurrencyFundamentalsView: View {
    var cryptocurrencyFundamentals: CryptocurrencyFundamentals
    var body: some View {
        VStack {
            TitleWithExchange(title: cryptocurrencyFundamentals.shortName, exchangeName: cryptocurrencyFundamentals.fullExchangeName)
            HStack {
                FundamentalDataList(fundamentalData: buildFirstDataList(from: cryptocurrencyFundamentals))
                SpacedDivider()
                FundamentalDataList(fundamentalData: buildSecondDataList(from: cryptocurrencyFundamentals))
            }.fixedSize()
        }.fixedSize()
    }
    
    private func buildFirstDataList(from fundamentals: CryptocurrencyFundamentals) -> [FundamentalDataList.RowItem] {
        return [
            FundamentalDataList.RowItem(label: "Market Cap", value: String(describing: fundamentals.marketCap.formatUsingAbbrevation())),
            FundamentalDataList.RowItem(label: "Open", value: fundamentals.regularMarketOpen.rounded(toPlaces: 2).formattedAsString()),
            FundamentalDataList.RowItem(label: "Day's Range", value: FundamentalsViewHelper.formatRange(range: fundamentals.regularMarketDayRange)),
            FundamentalDataList.RowItem(label: "52 Week Range", value: FundamentalsViewHelper.formatRange(range: fundamentals.fiftyTwoWeekRange))
        ]
    }
    
    private func buildSecondDataList(from fundamentals: CryptocurrencyFundamentals) -> [FundamentalDataList.RowItem] {
        return [
            FundamentalDataList.RowItem(label: "Previous Close", value: fundamentals.regularMarketPreviousClose.rounded(toPlaces: 2).formattedAsString()),
            FundamentalDataList.RowItem(label: "Volume", value: String(describing: fundamentals.regularMarketVolume.formatUsingAbbrevation())),
            FundamentalDataList.RowItem(label: "Start Date", value: FundamentalsViewHelper.valueAsStringOrNotAvailable(FundamentalsViewHelper.formatDateFromEpoch(fundamentals.startDate))),
            FundamentalDataList.RowItem(label: "Circulating Supply", value: Double(fundamentals.circulatingSupply).formattedAsString())
        ]
    }
}

//struct CryptocurrencyFundamentalsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CryptocurrencyFundamentalsView()
//    }
//}
