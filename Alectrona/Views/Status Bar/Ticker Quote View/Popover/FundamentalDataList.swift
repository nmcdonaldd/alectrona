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
            ForEach(fundamentalData.indices) { index in
                HStack {
                    Text(fundamentalData[index].label)
                        .font(.body)
                        .bold()
                        .foregroundColor(.primary)
                        .fixedSize()
                    Spacer(minLength: 20)
                    Text(fundamentalData[index].value)
                        .font(.callout)
                        .fixedSize()
                }
                if(index != fundamentalData.count-1) {
                    Spacer()
                }
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
