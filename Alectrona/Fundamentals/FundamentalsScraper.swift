//
//  FundamentalsScraper.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/12/21.
//

import Foundation
import SwiftSoup

class FundamentalsScraper {
    
    static let shared = FundamentalsScraper()
    
    private init() {}
    
    func getFundamentals(fromDocument document: Document) throws -> [String: String] {
        let tableElements = try document.select("table")
        let fundamentalsTable1 = tableElements[0]
        let fundamentalsTable2 = tableElements[1]
        
        let fundamentalsTable1Data = try getData(fromTableElement: fundamentalsTable1)
        let fundamentalsTable2Data = try getData(fromTableElement: fundamentalsTable2)
        
        return fundamentalsTable1Data.merging(fundamentalsTable2Data) { (current, new) in current }
    }
    
    private func getData(fromTableElement tableElement: Element) throws -> [String: String] {
        var tableData = [String: String]()
        let output = try tableElement.select("tr")
        for element in output {
            for td in try element.select("td") {
                if(td.hasAttr("data-test")) {
                    let key = try td.attr("data-test")
                    let value = try td.text()
                    tableData[key] = value
                }
            }
        }
        
        return tableData
    }
}
