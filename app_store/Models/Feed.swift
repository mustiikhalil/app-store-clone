//
//  Feed.swift
//  app_store
//
//  Created by Mustafa Khalil on 5/23/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import Foundation

struct Feed: Codable {
    let title: String
    let results: [FeedResults]
}

struct FeedResults: Codable {
    let name, artistName, artworkUrl100: String
}
