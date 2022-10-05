//
//  FundamentalsViewModel.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/13/21.
//

import Foundation
import Combine

class FundamentalsViewModel: ObservableObject {
    
    @Published var fundamentals: FundamentalsQuoteTypeResponse = .empty
    @Published var news: [News] = [News]()
    
    private var storage = Set<AnyCancellable>()
    
    init(
        fundamentalsPublisher: AnyPublisher<FundamentalsQuoteTypeResponse, Never>,
        newsPublisher: AnyPublisher<[News], Never>
    ) {
        fundamentalsPublisher
            .receive(on: RunLoop.main)
            .sink { self.fundamentals = $0 }
            .store(in: &storage)
        
        newsPublisher
            .receive(on: RunLoop.main)
            .sink { self.news = $0 }
            .store(in: &storage)
    }
}
