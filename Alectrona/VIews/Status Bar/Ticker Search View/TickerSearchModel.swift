//
//  TickerSearchModel.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/31/20.
//

import Foundation
import Combine

class TickerSearchModel: ObservableObject {
    // input
    @Published var searchText: String = ""
    
    // output
    @Published var searchResults: [TickerSearchResult] = [TickerSearchResult]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var searchTextPublisher: AnyPublisher<String, Never> {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            // Remove empty strings.
            .filter({ "" != $0 })
            .eraseToAnyPublisher()
    }
    
    private var resultsPublisher: AnyPublisher<[TickerSearchResult], Never> {
        searchTextPublisher
            .receive(on: RunLoop.main)
            .flatMap { API.searchTickers2($0) }
            .replaceError(with: [TickerSearchResult]())
            .eraseToAnyPublisher()
    }
    
    init() {
        resultsPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.searchResults, on: self)
            .store(in: &cancellableSet)
    }
    
    private func cancelAll() {
        cancellableSet.forEach({ $0.cancel() })
    }
    
    deinit {
        cancelAll()
    }
}
