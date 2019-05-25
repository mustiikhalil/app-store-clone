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
    
    func search<T: Codable>(url: URLRequest, completion: @escaping (Result<T, Error>) -> Void) -> [Operation] {
        
        let networkData = OperationsData<Data>()
        let result = OperationsData<T>()
        
        let delayOperation = DelayOperation(delay: .now() + .milliseconds(500))
        let fetchOperation = FetchOperation(with: url, result: networkData)
        let decodeOpration = DecodeOperation(data: networkData, result: result)
        
        delayOperation >>> fetchOperation
        fetchOperation >>> decodeOpration
        
        decodeOpration.completionBlock = {
            if let error = result.error {
                completion(.failure(error))
                return
            }
            if let data = result.data {
                completion(.success(data))
                return
            }
        }
        
        return [delayOperation, fetchOperation, decodeOpration]
        
    }
    
    func downloadImage(url: URLRequest, completion: @escaping (OperationsData<Data>) -> Void) -> [Operation] {
        let result = OperationsData<Data>()
        let fetchOperation = FetchOperation(with: url, result: result)
        
        fetchOperation.completionBlock = {
            DispatchQueue.main.async {
                completion(result)
            }
        }
        return [fetchOperation]
    }
    
    func fetchData<T: Codable>(url: URLRequest, completion: @escaping (Result<T, Error>) -> Void) -> [Operation] {
        
        let networkData = OperationsData<Data>()
        let result = OperationsData<T>()
        
        let fetchOperation = FetchOperation(with: url, result: networkData)
        let decodeOpration = DecodeOperation(data: networkData, result: result)
        
        fetchOperation >>> decodeOpration
        
        decodeOpration.completionBlock = {
            if let error = result.error {
                completion(.failure(error))
                return
            }
            if let data = result.data {
                completion(.success(data))
                return
            }
        }
        
        return [fetchOperation, decodeOpration]
    }
    
    func rssFeedUrl(type: String) -> URLRequest {
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/dk/ios-apps/\(type)/all/25/explicit.json")!
        return URLRequest(url: url)
    }
}
