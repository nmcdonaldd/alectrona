//
//  StatusItemViewable.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/8/21.
//

import Foundation
import SwiftUI

private struct StatusBarPreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = CGSize.zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
    
    typealias Value = CGSize
}

struct StatusItemViewable<Content>: View where Content: View {
    let content: Content
    let onSizeChange: (CGSize) -> Void
    
    @inlinable init(onSizeChange: @escaping (CGSize) -> Void, @ViewBuilder _ content: () -> Content) {
        self.onSizeChange = onSizeChange
        self.content = content()
    }
    
    var body: some View {
        content
            .background(GeometryReader { proxy in
                return Color.clear/*opacity(0.0)*/.preference(key: StatusBarPreferenceKey.self, value: proxy.size)
            }).onPreferenceChange(StatusBarPreferenceKey.self, perform: { value in
                DispatchQueue.main.async {
                    onSizeChange(value)
                }
            })
    }
}
