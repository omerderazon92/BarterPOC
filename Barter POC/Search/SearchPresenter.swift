//
//  SearchPresenter.swift
//  Barter POC
//
//  Created by Omer Derazon on 01/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation

protocol SearchPresenterCapabilities {
    func fetchSearchResults() -> [Item]
}

class SearchPresenter: SearchPresenterCapabilities {
    func fetchSearchResults() -> [Item] {
        return MockFactory.instance.provideSearchResults()
    }
}
