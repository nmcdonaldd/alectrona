//
//  Canceller.swift
//  Alectrona
//
//  Created by Nicholas McDonald on 4/12/21.
//

import Foundation
import Combine

class Canceller: Cancellable {
    
    private var cancelDelegate: () -> Void
    
    init(cancelDelegate: @escaping () -> Void) {
        self.cancelDelegate = cancelDelegate
    }
    
    func cancel() {
        cancelDelegate()
    }
}
