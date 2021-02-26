//
//  Constants.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/9/21.
//

import Foundation
import Defaults

struct NotificationKey {
    static let newTickerAdded = Notification.Name("notificationAdded")
}

struct UserDefaultsKey {
    static let watchlist = "watchlist"
}

struct YFinanceHTMLKey {
    struct Fundamentals {
        static let previousClose = "PREV_CLOSE-value"
        static let open = "OPEN-value"
        static let bid = "BID-value"
        static let ask = "ASK-value"
        static let daysRange = "DAYS_RANGE-value"
        static let fiftyTwoWeekRange = "FIFTY_TWO_WK_RANGE-value"
        static let todayVolume = "TD_VOLUME-value"
        static let threeMonthAverageVolume = "AVERAGE_VOLUME_3MONTH-value"
        static let marketCap = "MARKET_CAP-value"
        static let fiveYearBeta = "BETA_5Y-value"
        static let peReatio = "PE_RATIO-value"
        static let epsRatio = "EPS_RATIO-value"
        static let earningsDate = "EARNINGS_DATE-value"
        static let dividendAndYield = "DIVIDEND_AND_YIELD-value"
        static let exDividendDate = "EX_DIVIDEND_DATE-value"
        static let oneYearTargetPrice = "ONE_YEAR_TARGET_PRICE-value"
    }
}

struct Spacing {
    static let small: CGFloat = 6
    static let medium: CGFloat = 10
}

struct FeatureKey {
    static let newsStreaming = "STREAM_NEWS"
}

struct QuoteTypeKey {
    static let equity = "EQUITY"
    static let cryptocurrency = "CRYPTOCURRENCY"
}

extension Defaults.Keys {
    static let watchlist = Key<[String]>("watchlist", default: [String]())
    static let interfaceStyle = Key<String>("AppleInterfaceStyle", default: "Light")
}
