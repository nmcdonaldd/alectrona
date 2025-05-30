//
//  StockNewsController.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 2/4/21.
//

import Foundation
import Combine
import Factory

class StockNewsController {
    @Injected(Container.newsLinkController) private var newsLinkController: NewsLinkController
    @Injected(Container.newsController) private var newsController: NewsController
    
    func getStockNews(forSymbol symbol: String) -> AnyPublisher<[News], Never> {
        var storage = Set<AnyCancellable>()
        return newsLinkController.getNewsLinks(forSymbol: symbol)
            .flatMap { [unowned self] (newsLinks) -> AnyPublisher<[News], Never> in
                let newsLinkDispatchGroup = DispatchGroup()
                var outputNews = [News]()
                for newsLink in newsLinks {
                    newsLinkDispatchGroup.enter()
                    self.newsController.getNews(fromNewsLinks: newsLink)
                        .sink { news in
                            outputNews.append(news)
                            newsLinkDispatchGroup.leave()
                        }
                        .store(in: &storage)
                }
                
                let newsPassThroughSubject = PassthroughSubject<[News], Never>()
                newsLinkDispatchGroup.notify(queue: DispatchQueue.global(qos: .utility)) {
                    newsPassThroughSubject.send(outputNews)
                }
                
                return newsPassThroughSubject.eraseToAnyPublisher()
            }
            .replaceError(with: [News]())
            .eraseToAnyPublisher()
    }
}
