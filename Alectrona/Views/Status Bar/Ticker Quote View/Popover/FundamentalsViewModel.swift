//
//  FundamentalsViewModel.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/13/21.
//

import Foundation
import Combine

class FundamentalsViewModel: ObservableObject {
    
    @Published var fundamentals: Fundamentals = .empty
    private var storage = Set<AnyCancellable>()
    
    typealias FundamentalsPublisher = CurrentValueSubject<Fundamentals, Never>
    
    init(fundamentalsPublisher: FundamentalsPublisher) {
        fundamentalsPublisher
            .receive(on: RunLoop.main)
            .sink { self.fundamentals = $0 }
            .store(in: &storage)
    }
}
