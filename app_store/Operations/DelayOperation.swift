//
//  DelayOperation.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/21/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import Foundation

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
        
        timer.setEventHandler { [weak self] in
            self?.executing(false)
        }
        timer.schedule(deadline: delay)
        timer.resume()
    }
}
