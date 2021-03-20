//
//  FundamentalsTitle.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 3/10/21.
//

import SwiftUI

struct FundamentalsTitle: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title2)
            .bold()
            .foregroundColor(.primary)
    }
}

struct FundamentalsTitle_Previews: PreviewProvider {
    static var previews: some View {
        FundamentalsTitle(title: "Apple Inc.")
    }
}
