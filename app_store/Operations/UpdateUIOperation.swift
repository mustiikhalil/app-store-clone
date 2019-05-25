//
//  UpdateUIOperation.swift
//  app_store
//
//  Created by Mustafa Khalil on 5/25/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import Foundation

class UpdateUIOperation: BaseOperation {

    override init() {
        super.init()
        isAsynchronous = false
    }
    
    override func start() {
        guard !isCancelled else {
            return
        }
        executing(true)
        main()
    }
    
    override func main() {
        executing(false)
    }
}
