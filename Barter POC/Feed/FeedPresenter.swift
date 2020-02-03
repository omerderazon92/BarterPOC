//
//  FeedPresenter.swift
//  Barter POC
//
//  Created by Omer Derazon on 01/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation

protocol FeedPresenterCapabilities {
    func fetchCaegories() -> [Category]
}

class FeedPresenter: FeedPresenterCapabilities {
    func fetchCaegories() -> [Category] {
        return MockFactory.instance.provideUserCategories()
    }
}
