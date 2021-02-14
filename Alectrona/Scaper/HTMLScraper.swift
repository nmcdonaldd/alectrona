//
//  HTMLScraper.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/6/21.
//

import Foundation
import SwiftSoup

class HTMLScraper {
    func getDocument(fromURL url: URL) throws -> Document? {
        return try SwiftSoup.parse(String(contentsOf: url))
    }
}
