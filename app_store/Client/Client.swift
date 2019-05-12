//
//  Client.swift
//  app_store
//
//  Created by Mustafa Khalil on 5/12/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import Foundation

class Client {
    
    static var shared = Client()
    
    func search(url: URLRequest, completion: @escaping (OperationsData<SearchResults>) -> Void) -> [Operation] {
        
        let networkData = OperationsData<Data>()
        let result = OperationsData<SearchResults>()
        
        let delayOperation = DelayOperation(delay: .now() + .seconds(5))
        let fetchOperation = FetchOperation(with: url, result: networkData)
        let decodeOpration = DecodeOperation(data: networkData, result: result)
        
        delayOperation >>> fetchOperation
        fetchOperation >>> decodeOpration
        
        decodeOpration.completionBlock = {
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        return [delayOperation, fetchOperation, decodeOpration]
        
    }
}