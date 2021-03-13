//
//  FundamentalDataList.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/13/21.
//

import Foundation
import SwiftUI

struct FundamentalDataList: View {
    struct RowItem {
        var label: String
        var value: String
    }
    
    var fundamentalData: [RowItem]
    var body: some View {
        VStack {
            ForEach(fundamentalData.indices) { index in
                HStack {
                    Text(fundamentalData[index].label)
                        .font(.body)
                        .fixedSize()
                        .interfaceStyleRespectingGray()
                    Spacer(minLength: 20)
                    Text(fundamentalData[index].value)
                        .font(.body)
                        .foregroundColor(.primary)
                        .bold()
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
            FundamentalDataList(fundamentalData: [FundamentalDataList.RowItem(label: "Market Cap", value: "42.713B"), FundamentalDataList.RowItem(label: "Open", value: "282.20")])
            Divider()
            FundamentalDataList(fundamentalData: [FundamentalDataList.RowItem(label: "Market Cap", value: "42.713B"), FundamentalDataList.RowItem(label: "Open", value: "282.20")])
        }
    }
}
#endif
