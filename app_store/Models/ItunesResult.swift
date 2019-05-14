//
//  ItunesResults.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/27/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import Foundation

struct ItunesResult: Codable {
    let trackName: String
    let primaryGenreName: String
    let artworkUrl100: String
    let screenshotUrls: [String]
    let averageUserRating: Double?
}
