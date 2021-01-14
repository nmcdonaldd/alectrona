//
//  FundamentalDataList.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/13/21.
//

import Foundation
import SwiftUI

struct FundamentalDataList: View {
    struct FundamentalDataRow {
        var label: String
        var value: String
    }
    
    var fundamentalData: [FundamentalDataRow]
    var body: some View {
        VStack {
            ForEach(fundamentalData, id: \.label) { fundamentalDataPoint in
                HStack {
                    Text(fundamentalDataPoint.label)
                        .foregroundColor(.gray)
                        .fixedSize()
                    Spacer(minLength: 20)
                    Text(fundamentalDataPoint.value)
                        .bold()
                        .foregroundColor(.primary)
                        .fixedSize()
                }
                // FIXME: Move to soem reduce function
                // FIXME: Only put spacer in between two rows.
                Spacer()
            }
        }.fixedSize()
    }
}

#if DEBUG
struct FundamentalDataListPreview: PreviewProvider {
    static var previews: some View {
        HStack {
            FundamentalDataList(fundamentalData: [FundamentalDataList.FundamentalDataRow(label: "Market Cap", value: "42.713B"), FundamentalDataList.FundamentalDataRow(label: "Open", value: "282.20")])
            Divider()
            FundamentalDataList(fundamentalData: [FundamentalDataList.FundamentalDataRow(label: "Market Cap", value: "42.713B"), FundamentalDataList.FundamentalDataRow(label: "Open", value: "282.20")])
        }
    }
}
#endif
