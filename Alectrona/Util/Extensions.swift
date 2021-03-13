//
//  Extensions.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 12/27/20.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Int {
    func formatUsingAbbrevation () -> String {
        let numFormatter = NumberFormatter()

        typealias Abbrevation = (threshold: Double, divisor: Double, suffix: String)
        let abbreviations:[Abbrevation] = [
            (0, 1, ""),
            (1000.0, 1000.0, "K"),
            (1_000_000.0, 1_000_000.0, "M"),
            (1_000_000_000.0, 1_000_000_000.0, "B"),
            (1_000_000_000_000.0, 1_000_000_000_000.0, "T")
        ]

        let startValue = Double (abs(self))
        let abbreviation: Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if (startValue < tmpAbbreviation.threshold) {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        }()

        let value = Double(self) / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 2

        return numFormatter.string(from: NSNumber(value: value))!
    }

}
