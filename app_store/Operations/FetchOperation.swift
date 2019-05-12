//
//  FetchOperation.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/21/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import Foundation
import os.log

class FetchOperation: BaseOperation {
    
    let urlRequest: URLRequest
    let result: OperationsData<Data>
    
    init(with urlRequest: URLRequest, result: OperationsData<Data>) {
        self.urlRequest = urlRequest
        self.result = result
        super.init()
        isAsynchronous = false
    }
    
    override func start() {
        guard !isCancelled else {
            executing(false)
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
        os_log("%@ - %@", type: .debug, urlRequest.httpMethod ?? "", self.urlRequest.url?.absoluteString ?? "not a url")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            let response = urlResponse as? HTTPURLResponse
            
            os_log("%ld - %@", type: .debug, response?.statusCode ?? -100, self.urlRequest.url?.absoluteString ?? "not a url")
            
            guard !self.isCancelled else {
                self.executing(false)
                return
            }
            
            if let error = error {
                self.result.error = error
                self.executing(false)
                return
            }
            guard let data = data, response?.statusCode == 200 else {
                self.result.error = AppStoreError.networkError(response?.statusCode)
                self.executing(false)
                return
            }
            
            self.result.data = data
            self.executing(false)
            
        }.resume()
    }
}

enum AppStoreError: Error {
    case networkError(Int?)
}
