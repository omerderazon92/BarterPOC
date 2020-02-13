//
//  OpenOffersPresenter.swift
//  Barter POC
//
//  Created by Omer Derazon on 11/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation

protocol OpenOffersPresnterProtocol {
    func fetchInventory() -> [Item]
}

class OpenOffersPresenter: OpenOffersPresnterProtocol {
    func fetchInventory() -> [Item] {
        MockFactory.instance.provideBestRecommendations()
    }
}
