//
//  FundamentalsViewHelper.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 3/17/21.
//

import Foundation

class FundamentalsViewHelper {
    class func formatRange(range: String) -> String {
        let components = range.components(separatedBy: " - ")
        guard let lowerRangeValue = Double(components[0]), let upperRangeValue = Double(components[1]) else {
            return range
        }
        
        return "\(lowerRangeValue.formattedAsString()) - \(upperRangeValue.formattedAsString())"
    }
    
    class func valueAsStringOrNotAvailable<T>(_ value: T?) -> String {
        if let nonNullValue = value {
            return String(describing: nonNullValue)
        }
        return "N/A"
    }
    
    class func formatDateFromEpoch(_ timeSince1970: Int?) -> String? {
        guard let time = timeSince1970 else {
            return nil
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
        return dateFormatter.string(from: date)
    }
}
