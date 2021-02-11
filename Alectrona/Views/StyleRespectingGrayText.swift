//
//  StyleRespectingGrayText.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/11/21.
//

import SwiftUI

struct InterfaceStyleRespectedGray: ViewModifier {
    
    @AppStorage("AppleInterfaceStyle") var interfaceStyle = "Light"
    
    var color: Color {
        if("Light" == interfaceStyle) {
            return Color(NSColor.darkGray)
        }
        
        return Color(NSColor.lightGray)
    }
    
    func body(content: Content) -> some View {
        content.foregroundColor(color)
    }
}

extension View {
    func interfaceStyleRespectingGray() -> some View {
        self.modifier(InterfaceStyleRespectedGray())
    }
}
