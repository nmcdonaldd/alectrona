//
//  LiveQuotePopoverView.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/7/21.
//

import Foundation
import SwiftUI

struct LiveQuotePopoverView: View {
    
    @ObservedObject var fundamentalsViewModel: FundamentalsViewModel
    
    var body: some View {
        if(fundamentalsViewModel.fundamentals == nil) {
            Text("Loading...")
        } else {
            HStack{
                FundamentalDataList(fundamentalData: buildFundamentalDataListColumn1(fromFundamentals: fundamentalsViewModel.fundamentals!))
                Spacer(minLength: 10)
                Divider()
                Spacer(minLength: 10)
                FundamentalDataList(fundamentalData: buildFundamentalDataListColumn2(fromFundamentals: fundamentalsViewModel.fundamentals!))
            }.padding()
        }
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
