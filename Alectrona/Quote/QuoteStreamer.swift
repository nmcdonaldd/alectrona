//
//  QuoteStreamer.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 3/20/21.
//

import Foundation
import Combine
import Starscream

class QuoteStreamer {
    
    private struct StreamQuoteMessage: Encodable {
        var subscribe: [String]
    }
    
    func streamQuote(forSymbol: String) -> LiveQuoteStream {
        let webSocket = WebSocket(request: URLRequest(url: Endpoint.streamQuote().url))
        let passthroughSubject = PassthroughSubject<Quote, Never>()
        
        webSocket.onEvent = { event in
            switch event {
            case .connected(_):
                // In this case, we need to now send a message saying which symbol we'd like to listen to
                let data = try! JSONEncoder().encode(StreamQuoteMessage(subscribe: [forSymbol]))
                webSocket.write(string: String(data: data, encoding: .utf8)!)
            case .text(let base64EncodedMessage):
                let data = Data(base64Encoded: base64EncodedMessage)!
                
                // Now, convert data to a PricingData protobuf-enabled struct
                let pricingData = try! PricingData(contiguousBytes: data)
                passthroughSubject.send(
                    StreamedQuote(
                        regularMarketPrice: Double(pricingData.price),
                        percentageGain: Double(pricingData.changePercent) / 100.0))
            default:
                // I don't know what to put here but I have to put *something*
                print(event)
            }
        }
        
        webSocket.connect()
        return LiveQuoteStream(quotePublisher: passthroughSubject.eraseToAnyPublisher(), canceller: Canceller(cancelDelegate: {
            webSocket.disconnect()
        }))
    }
}
