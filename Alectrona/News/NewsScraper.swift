//
//  NewsScraper.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/6/21.
//

import Foundation
import SwiftSoup

typealias NewsText = [String]
class NewsScraper {
    static func getNewsText(fromDocument document: Document) -> NewsText {
        do {
            let elements: Elements? = try document.select("div.caas-body")
            guard let paragraphContainers = elements?.first() else {
                return [String]()
            }
            
            return try paragraphContainers.select("p")
                .map { try $0.text() }
        } catch {
            return [String]()
        }
    }
}
