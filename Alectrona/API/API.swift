//
//  Ticker.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/26/20.
//

import Foundation
import Combine
import Starscream

class API {
    func get<T>(type: T.Type, url: URL) -> AnyPublisher<T, Error> where T: Decodable {
        return get(url: url)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func get(url: URL) -> AnyPublisher<Data, URLSession.DataTaskPublisher.Failure> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
