//
//  BackgroundJobConfiguration.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/25/21.
//

import Foundation
import Combine

protocol BackgroundJobConfiguration {
    associatedtype JobOutput
    
    var jobIdentifier: String { get }
    var interval: Double { get }
    var quality: QualityOfService { get }
    var repeats: Bool { get }
    var tolerance: Double { get }
    
    func doJob() -> AnyPublisher<JobOutput, Never>
}

extension BackgroundJobConfiguration {
    var tolerance: Double {
        0.0
    }
}
