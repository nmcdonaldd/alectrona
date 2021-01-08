//
//  HTMLScraper.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/6/21.
//

import Foundation
import SwiftSoup

class HTMLScraper {
    class func getDocument(fromURL url: URL) throws -> Document? {
        do {
            return try SwiftSoup.parse(String(contentsOf: url))
        } catch let error {
            throw ScraperError(error: error)
        }
    }
}

private struct ScraperError: Error {
    init(error: Error) {
        
    }
}
