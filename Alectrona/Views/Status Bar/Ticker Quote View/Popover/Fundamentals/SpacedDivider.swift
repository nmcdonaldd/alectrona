//
//  SpacedDivider.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/26/21.
//

import SwiftUI

struct SpacedDivider: View {
    var spacing: CGFloat = Spacing.medium
    var body: some View {
        Spacer(minLength: spacing)
        Divider()
        Spacer(minLength: spacing)
    }
}

struct SpacedDivider_Previews: PreviewProvider {
    static var previews: some View {
        SpacedDivider(spacing: Spacing.medium)
    }
}
