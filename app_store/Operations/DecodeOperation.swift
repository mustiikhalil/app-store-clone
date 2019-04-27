//
//  DecodeOperation.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/27/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import Foundation
import os.log

class DecodeOperation<T: Codable>: BaseOperation {
    
    fileprivate let data: OperationsData<Data>
    let result: OperationsData<T>
    
    init(data: OperationsData<Data>, result: OperationsData<T>) {
        self.data = data
        self.result = result
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
        
        guard !isCancelled else {
            executing(false)
            return
        }
        os_log("Decode operation started", type: .debug)
        guard data.error == nil else {
            result.error = data.error
            executing(false)
            return
        }
        
        guard let currentData = data.data else {
            executing(false)
            return
        }
        
        do {
            result.data = try JSONDecoder().decode(T.self, from: currentData)
        } catch {
            result.error = error
        }
        executing(false)
    }
}
