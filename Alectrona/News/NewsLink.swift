//
//  NewsLink.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/6/21.
//

import Foundation

struct NewsLink: Decodable {
    var title: String
    var publisher: String
    var link: String
    var providerPublishTime: Int64
}
