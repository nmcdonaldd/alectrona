//
//  NewsScraper.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/6/21.
//

import Foundation
import SwiftSoup

class NewsScraper {
    
    struct NewsScraperError: Error {
        
    }
    
    typealias NewsText = String
    
    static func getNewsText(fromDocument document: Document) -> NewsText {
        do {
            let elements: Elements? = try document.select("div.cass-body")
            let firstPerhaps = elements?.first()
            
            guard let first = firstPerhaps else {
                throw NewsScraperError()
            }
            
            print(first)
        } catch let error {
            print(error)
        }
        
        return "poop"
    }
}
