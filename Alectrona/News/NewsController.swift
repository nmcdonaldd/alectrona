//
//  NewsController.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/5/21.
//

import Foundation
import Combine
import Factory

class NewsController {
    
    @Injected(Container.htmlScraper) private var htmlScraper: HTMLScraper
    
    struct NewsError: Error {
        var message: String
    }
    
    func getNews(fromNewsLinks newsLink: NewsLink) -> AnyPublisher<News, Never> {
        return Future<News, Never> { [unowned self] promise in
            DispatchQueue.global(qos: .utility).async {
                do {
                    guard let url = URL(string: newsLink.link),
                          let document = try self.htmlScraper.getDocument(fromURL: url) else {
                        return
                    }
                    
                    promise(
                        .success(
                            News(
                                publishedTime: newsLink.providerPublishTime,
                                title: newsLink.title,
                                newsText: NewsScraper.getNewsText(fromDocument: document),
                                publisher: newsLink.publisher,
                                url: newsLink.link)))
                } catch {
                    return
                }
            }
        }.eraseToAnyPublisher()
    }
}
