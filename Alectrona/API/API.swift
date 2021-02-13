//
//  Ticker.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/26/20.
//

import Foundation
import Combine

class API {
    func get<T>(type: T.Type, url: URL) -> AnyPublisher<T, Error> where T: Decodable {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
