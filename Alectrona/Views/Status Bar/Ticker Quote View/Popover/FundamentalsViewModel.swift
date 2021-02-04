//
//  FundamentalsViewModel.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/13/21.
//

import Foundation
import Combine

typealias FundamentalsPublisher = CurrentValueSubject<Fundamentals, Never>
class FundamentalsViewModel: ObservableObject {
    
    @Published var fundamentals: Fundamentals = .empty
    private var storage = Set<AnyCancellable>()
    
    init(fundamentalsPublisher: AnyPublisher<Fundamentals, Never>) {
        fundamentalsPublisher
            .receive(on: RunLoop.main)
            .sink { self.fundamentals = $0 }
            .store(in: &storage)
    }
}
