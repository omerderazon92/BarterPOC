//
//  UserSpecialRecommendationPresenter.swift
//  Barter POC
//
//  Created by Omer Derazon on 01/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation

protocol UserSpecialRecommendationsPresenterCapabilities {
    func fetchSpecialRecommendations(with category:Category) -> [Item]
}

class UserSpecialRecommendationsPresenter: UserSpecialRecommendationsPresenterCapabilities {
    func fetchSpecialRecommendations(with category:Category) -> [Item] {
        return MockFactory.instance.provideUserRecommendations(with: category)
    } 
}
