//
//  BackgroundJobSubmission.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/25/21.
//

import Foundation
import Combine

struct BackgroundJobSubmission<JobOutput> {
    private let outputPublisher: AnyPublisher<JobOutput, Never>
    
    var publisher: AnyPublisher<JobOutput, Never> {
        return outputPublisher.eraseToAnyPublisher()
    }
    
    init(ouputPublisher: AnyPublisher<JobOutput, Never>) {
        self.outputPublisher = ouputPublisher
    }
}
