//
//  MyItemsViewControllerPresenter.swift
//  Barter POC
//
//  Created by Omer Derazon on 08/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation

protocol MyItemsPresenterCapabilities {
    func fetchItems() -> [Item]
    func fetchNumberOfCurrentOffers() -> Int
}

class MyItemsPresenter: MyItemsPresenterCapabilities {
    
    func fetchNumberOfCurrentOffers() -> Int {
        let bestReccomendations = MockFactory.instance.provideBestRecommendations()
        var incVar = 0
        for item in bestReccomendations {
            incVar += item.currentOffers?.count ?? 0
        }
        return incVar
    }
    
    func fetchItems() -> [Item] {
        MockFactory.instance.provideBestRecommendations()
    }
}
