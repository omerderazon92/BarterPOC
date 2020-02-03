//
//  BestRecommendationsPresenter.swift
//  Barter POC
//
//  Created by Omer Derazon on 01/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation

protocol BestRecommendationsPresenterCapabilities {
    func fetchRecommendations() -> [Item]?
}

class BestRecommendationsPresenter: BestRecommendationsPresenterCapabilities {
    func fetchRecommendations() -> [Item]? {
        return MockFactory.instance.provideBestRecommendations()
    }
}
