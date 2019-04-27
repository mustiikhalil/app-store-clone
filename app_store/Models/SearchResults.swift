//
//  Results.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/27/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    let resultCount: Int
    let results: [ItunesResult]
}
