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
    @Published var searchResults: [Ticker] = [Ticker]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    private var tickerController = TickerController()
    
    private var searchTextPublisher: AnyPublisher<String, Never> {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            // Remove empty strings.
            .filter({ "" != $0 })
            .eraseToAnyPublisher()
    }
    
    private var resultsPublisher: AnyPublisher<[Ticker], Never> {
        searchTextPublisher
            .receive(on: RunLoop.main)
            .flatMap { [unowned self] searchText in
                return self.tickerController.searchTickers(withText: searchText)
            }
            .replaceError(with: [Ticker]())
            .eraseToAnyPublisher()
    }
    
    init() {
        resultsPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.searchResults, on: self)
            .store(in: &cancellableSet)
    }
    
    deinit {
        cancellableSet.forEach({ $0.cancel() })
    }
}
