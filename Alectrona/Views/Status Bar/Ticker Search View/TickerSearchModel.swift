//
//  TickerSearchModel.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/31/20.
//

import Foundation
import Combine
import Factory

class TickerSearchModel: ObservableObject {
    // input
    @Published var searchText: String = ""
    
    // output
    @Published var searchResults: [Ticker] = [Ticker]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    @Injected(Container.ticketController) private var tickerController: TickerController
    
    private var searchTextPublisher: AnyPublisher<String, Never> {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.current)
            .removeDuplicates()
            // Remove empty strings.
            .filter { "" != $0 }
            .eraseToAnyPublisher()
    }
    
    private var resultsPublisher: AnyPublisher<[Ticker], Never> {
        searchTextPublisher
            .flatMap { self.tickerController.searchTickers(withText: $0) }
            .replaceError(with: [Ticker]())
            .eraseToAnyPublisher()
    }
    
    init() {
        resultsPublisher
            .receive(on: RunLoop.main)
            .assign(to: &$searchResults)
    }
}
