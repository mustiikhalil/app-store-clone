//
//  DelayOperation.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/21/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import Foundation
import os.log

class DelayOperation: BaseOperation {
    
    fileprivate let delay: DispatchTime
    fileprivate let timer = DispatchSource.makeTimerSource()
    
    init(delay: DispatchTime) {
        self.delay = delay
        super.init()
    }
    
    override func main() {
        guard !isCancelled else {
            executing(false)
            return
        }
        executing(true)
        
        os_log("Delay operation started", type: .debug)
        
        timer.setEventHandler { [weak self] in
            os_log("Delay operation done", type: .debug)
            self?.executing(false)
        }
        timer.schedule(deadline: delay)
        timer.resume()
    }
}
