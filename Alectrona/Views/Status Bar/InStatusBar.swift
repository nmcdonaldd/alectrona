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

struct InStatusBar: ViewModifier {
    var onSizeChange: (CGSize) -> Void
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { proxy in
                return Color.clear.preference(key: StatusBarPreferenceKey.self, value: proxy.size)
            }).onPreferenceChange(StatusBarPreferenceKey.self, perform: { value in
                DispatchQueue.main.async {
                    onSizeChange(value)
                }
            })
    }
}

extension View {
    func inStatusBar(onSizeChange: @escaping (CGSize) -> Void) -> some View {
        self.modifier(InStatusBar(onSizeChange: onSizeChange))
    }
}
