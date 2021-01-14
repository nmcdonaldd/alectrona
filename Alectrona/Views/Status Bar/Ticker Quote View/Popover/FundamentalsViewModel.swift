//
//  FundamentalsViewModel.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/13/21.
//

import Foundation

class FundamentalsViewModel: ObservableObject {
    let symbol: String
    
    @Published var fundamentals: Fundamentals? = nil
    
    init(symbol: String) {
        self.symbol = symbol
        getFundamentals()
    }
    
    private func getFundamentals() {
        DispatchQueue.global(qos: .background).async {
            var fundamentals: Fundamentals? = nil
            do {
                fundamentals = try FundamentalsController().getFundamentalsForSymbol(self.symbol)
            } catch {
                print("something went wrong")
            }
            
            DispatchQueue.main.async {
                self.fundamentals = fundamentals
            }
        }
    }
}
