//
//  Canceller.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 4/12/21.
//

import Foundation
import Combine

class Canceller: Cancellable {
    typealias CancelDelegate = () -> Void
    
    private var cancelDelegate: CancelDelegate
    
    init(cancelDelegate: @escaping CancelDelegate) {
        self.cancelDelegate = cancelDelegate
    }
    
    func cancel() {
        cancelDelegate()
    }
}
