//
//  AppPageViewModel.swift
//  app_store
//
//  Created by Mustafa Khalil on 5/25/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import Foundation

class AppsPageViewModel {
    
    var modelType: PageType
    var appGroup: AppGroup?
    
    init(type: PageType) {
        modelType = type
        appGroup = nil
    }
    
    enum PageType: String {
        var id: String {
            return self.rawValue
        }
        case newGamesWeLove = "new-games-we-love"
        case newAppsWeLove = "new-apps-we-love"
        case topFree = "top-free"
        case topGrossing = "top-grossing"
        case topPaid = "top-paid"
    }
    
    static func create() -> [AppsPageViewModel] {
        return [
            AppsPageViewModel(type: .newAppsWeLove),
            AppsPageViewModel(type: .newGamesWeLove),
            AppsPageViewModel(type: .topGrossing),
            AppsPageViewModel(type: .topPaid),
            AppsPageViewModel(type: .topFree),
        ]
    }
}
