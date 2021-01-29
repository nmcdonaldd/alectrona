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
    
    func doJob() -> AnyPublisher<JobOutput, Never>
}
