//
//  Quote.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 3/21/21.
//

import Foundation

protocol Quote {
    var regularMarketPrice: Double { get }
    var percentageGain: Double { get }
}
