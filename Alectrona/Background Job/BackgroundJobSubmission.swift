//
//  BackgroundJobSubmission.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/25/21.
//

import Foundation
import Combine

struct BackgroundJobSubmission<JobOutput>: Cancellable {
    typealias BackgroundJobCanceller = () -> ()
    private let outputPublisher: AnyPublisher<JobOutput, Never>
    
    var publisher: AnyPublisher<JobOutput, Never> {
        return outputPublisher.eraseToAnyPublisher()
    }
    
    private let canceller: () -> ()
    
    init(ouputPublisher: AnyPublisher<JobOutput, Never>, canceller: @escaping () -> ()) {
        self.outputPublisher = ouputPublisher
        self.canceller = canceller
    }
    
    func cancel() {
        canceller()
    }
}
