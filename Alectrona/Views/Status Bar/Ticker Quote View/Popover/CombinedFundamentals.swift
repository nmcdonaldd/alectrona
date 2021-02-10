//
//  CombinedFundamentals.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/9/21.
//

import SwiftUI

struct CombinedFundamentals: View {
    var fundamentals: Fundamentals
    var body: some View {
        HStack {
            FundamentalDataList(fundamentalData: buildFundamentalDataListColumn1(fromFundamentals: fundamentals))
            Spacer(minLength: Spacing.medium)
            Divider()
            Spacer(minLength: Spacing.medium)
            FundamentalDataList(fundamentalData: buildFundamentalDataListColumn2(fromFundamentals: fundamentals))
        }.fixedSize()
    }
    
    private func buildFundamentalDataListColumn1(fromFundamentals fundamentals: Fundamentals) -> [FundamentalDataList.FundamentalDataRow] {
        var fundamentalDataList = [FundamentalDataList.FundamentalDataRow]()
        fundamentalDataList.append(FundamentalDataList.FundamentalDataRow(label: "Market Cap", value: fundamentals.marketCap))
        fundamentalDataList.append(FundamentalDataList.FundamentalDataRow(label: "Open", value: fundamentals.open))
        fundamentalDataList.append(FundamentalDataList.FundamentalDataRow(label: "Bid", value: fundamentals.bid))
        fundamentalDataList.append(FundamentalDataList.FundamentalDataRow(label: "Ask", value: fundamentals.ask))
        fundamentalDataList.append(FundamentalDataList.FundamentalDataRow(label: "Day's Range", value: fundamentals.daysRange))
        fundamentalDataList.append(FundamentalDataList.FundamentalDataRow(label: "52 Week Range ", value: fundamentals.fiftyTwoWeekRange))
        
        return fundamentalDataList
    }
    
    private func buildFundamentalDataListColumn2(fromFundamentals fundamentals: Fundamentals) -> [FundamentalDataList.FundamentalDataRow] {
        var fundamentalDataList = [FundamentalDataList.FundamentalDataRow]()
        fundamentalDataList.append(FundamentalDataList.FundamentalDataRow(label: "Previous Close", value: fundamentals.previousClose))
        fundamentalDataList.append(FundamentalDataList.FundamentalDataRow(label: "Volume", value: fundamentals.todayVolume))
        fundamentalDataList.append(FundamentalDataList.FundamentalDataRow(label: "PE Ratio", value: fundamentals.peRatio))
        fundamentalDataList.append(FundamentalDataList.FundamentalDataRow(label: "EPS Ratio", value: fundamentals.epsRatio))
        fundamentalDataList.append(FundamentalDataList.FundamentalDataRow(label: "Earnings Date", value: fundamentals.earningsDate))
        fundamentalDataList.append(FundamentalDataList.FundamentalDataRow(label: "Dividend & Yield", value: fundamentals.dividendAndYield))
        
        return fundamentalDataList
    }
}

struct CombinedFundamentals_Previews: PreviewProvider {
    static var previews: some View {
        CombinedFundamentals(fundamentals: .empty)
    }
}
