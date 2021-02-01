//
//  BackgroundJobSubmitter.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 1/25/21.
//

import Foundation
import Combine

class BackgroundJobSumitter {
    
    class func submit<Configuration, Output>(jobConfiguration: Configuration) -> BackgroundJobSubmission<Output> where Configuration: BackgroundJobConfiguration, Output == Configuration.JobOutput {
        let backgroundJobScheduler = NSBackgroundActivityScheduler(identifier: jobConfiguration.jobIdentifier)
        backgroundJobScheduler.interval = jobConfiguration.interval
        backgroundJobScheduler.qualityOfService = jobConfiguration.quality
        backgroundJobScheduler.repeats = jobConfiguration.repeats
        
        let outputPassthroughSubject = PassthroughSubject<Output, Never>()
        var storage = Set<AnyCancellable>()
        backgroundJobScheduler.schedule { completionHandler in
            if(backgroundJobScheduler.shouldDefer) {
                completionHandler(.deferred)
            }
            
            jobConfiguration.doJob()
                .sink { output in
                    outputPassthroughSubject.send(output)
                    completionHandler(.finished)
                }
                .store(in: &storage)
        }
        
        return BackgroundJobSubmission(ouputPublisher: outputPassthroughSubject.eraseToAnyPublisher())
    }
}
