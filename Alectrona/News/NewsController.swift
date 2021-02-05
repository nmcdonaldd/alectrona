//
//  NewsController.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/5/21.
//

import Foundation
import Combine

class NewsController {
    
    struct NewsError: Error {
        var message: String
    }
    
    func getNews(fromNewsLinks newsLinks: [NewsLink]) throws -> [News] {
        do {
            return try newsLinks.map { newsLink in
                guard let url = URL(string: newsLink.link) else {
                    throw NewsError(message: "Cannot parse error")
                }
                
                guard let document = try HTMLScraper.getDocument(fromURL: url) else {
                    throw NewsError(message: "Cannot get document")
                }
                
                return News(publishedTime: newsLink.providerPublishTime,
                            newsText: NewsScraper.getNewsText(fromDocument: document),
                            publisher: newsLink.publisher,
                            url: newsLink.link)
            }
        } catch let error {
            throw error
        }
    }
}
