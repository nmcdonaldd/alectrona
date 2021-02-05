//
//  News.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/5/21.
//

import Foundation

struct News {
    var publishedTime: Int64
    var newsText: NewsText
    var publisher: String
    var url: String //FIXME: move to URL type?
}
