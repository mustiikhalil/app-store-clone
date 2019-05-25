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
        os_log("%@ - %@", type: .debug, urlRequest.httpMethod ?? "", urlRequest.url?.absoluteString ?? "not a url")
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, urlResponse, error) in
            let response = urlResponse as? HTTPURLResponse
            os_log("%ld - %@", type: .debug, response?.statusCode ?? -100, self?.urlRequest.url?.absoluteString ?? "not a url")
            self?.handleReturnedData(data: data, response: response, error: error)
        }.resume()
    }
    
    func handleReturnedData(data: Data?, response: HTTPURLResponse?, error: Error?) {
        guard !isCancelled else {
            executing(false)
            return
        }
        
        if let error = error {
            result.error = error
            executing(false)
            return
        }
        guard let data = data, response?.statusCode == 200 else {
            result.error = AppStoreError.networkError(response?.statusCode)
            executing(false)
            return
        }
        
        result.data = data
        executing(false)
        
    }
}

enum AppStoreError: Error {
    case networkError(Int?)
}
