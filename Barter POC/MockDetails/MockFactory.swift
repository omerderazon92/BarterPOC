//
//  MockFactory.swift
//  Barter POC
//
//  Created by Omer Derazon on 01/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class MockFactory {
    
    static let instance = MockFactory()
    
    private var bestReccomendations:[Item]?
    
    func provideBestRecommendations() -> [Item] {
        
        if bestReccomendations == nil {
             let backpack1 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                                images: [UIImage(imageLiteralResourceName: "backpack1")])
             let backpack2 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                                images: [UIImage(imageLiteralResourceName: "backpack2")])
             let backpack3 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                                images: [UIImage(imageLiteralResourceName: "backpack3")])
             let backpack4 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                                images: [UIImage(imageLiteralResourceName: "backpack4")])
             let backpack5 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                                images: [UIImage(imageLiteralResourceName: "backpack5")])
             let backpack6 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                                images: [UIImage(imageLiteralResourceName: "backpack6")])
             let backpack7 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                                images: [UIImage(imageLiteralResourceName: "backpack7")])
             let backpack8 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                                images: [UIImage(imageLiteralResourceName: "backpack8")])
             
             let dyson = Item(id: "1", name: "דייסון", owner: "1a", category: "Vacooms",
                              images: [UIImage(imageLiteralResourceName: "dyson_vacume")], currentOffers:
             [Offer(owner: "1", ownerInventory: [backpack1]),
             Offer(owner: "2", ownerInventory: [backpack2, backpack3, backpack4,
                                             backpack5, backpack6, backpack7, backpack8])])
            
             let sonyPlaystation = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                             images: [UIImage(imageLiteralResourceName: "sony_playstation")])
             
             let electricBicycle = Item(id: "3", name: "אופניים חשמליים", owner: "3c", category: "ElectricBicycle",
                                         images: [UIImage(imageLiteralResourceName: "electric_bicycle")])
             
             
             bestReccomendations = [electricBicycle, dyson, sonyPlaystation]
        }
        
        return bestReccomendations!
    }
    
    func provideUserCategories() -> [Category] {
        let sonyCategory = Category(id: "2", name: "מוצרי חשמל", subName: "סוני פלייסטיישן 4")
        let backpackCategory = Category(id: "1", name: "תיקי גב", subName: nil)
        return [backpackCategory, sonyCategory]
    }
    
    func provideUserRecommendations(with category: Category) -> [Item] {
        switch category.id {
        case "1":
            let backpack1 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                    images: [UIImage(imageLiteralResourceName: "backpack1")])
            let backpack2 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                    images: [UIImage(imageLiteralResourceName: "backpack2")])
            let backpack3 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                    images: [UIImage(imageLiteralResourceName: "backpack3")])
            let backpack4 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                    images: [UIImage(imageLiteralResourceName: "backpack4")])
            let backpack5 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                    images: [UIImage(imageLiteralResourceName: "backpack5")])
            let backpack6 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                    images: [UIImage(imageLiteralResourceName: "backpack6")])
            let backpack7 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                    images: [UIImage(imageLiteralResourceName: "backpack7")])
            let backpack8 = Item(id: "3", name: "תיק יפה", owner: "3a", category: "BackPacks",
                                    images: [UIImage(imageLiteralResourceName: "backpack8")])
            return [backpack1, backpack2, backpack3, backpack4, backpack5, backpack6, backpack7, backpack8,
                        backpack1, backpack2, backpack3, backpack4, backpack5, backpack6, backpack7, backpack8]
            
        case "2":
            let sonyPlaystation1 = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                                          images: [UIImage(imageLiteralResourceName: "sony_playstation")])
            let sonyPlaystation2 = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                                          images: [UIImage(imageLiteralResourceName: "sony_playstation2")])
            let sonyPlaystation3 = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                                          images: [UIImage(imageLiteralResourceName: "sony_playstation3")])
            let sonyPlaystation4 = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                                          images: [UIImage(imageLiteralResourceName: "sony_playstation4")])
            let sonyPlaystation5 = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                                          images: [UIImage(imageLiteralResourceName: "sony_playstation5")])
            let sonyPlaystation6 = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                                          images: [UIImage(imageLiteralResourceName: "sony_playstation6")])
            return [sonyPlaystation1, sonyPlaystation2, sonyPlaystation3, sonyPlaystation4,
                    sonyPlaystation5, sonyPlaystation6]

        default:
            return []
        }
    }

    func provideSearchResults() -> [Item] {
        let sonyPlaystation1 = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                                      images: [UIImage(imageLiteralResourceName: "sony_playstation")])
        let sonyPlaystation2 = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                                      images: [UIImage(imageLiteralResourceName: "sony_playstation2")])
        let sonyPlaystation3 = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                                      images: [UIImage(imageLiteralResourceName: "sony_playstation3")])
        let sonyPlaystation4 = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                                      images: [UIImage(imageLiteralResourceName: "sony_playstation4")])
        let sonyPlaystation5 = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                                      images: [UIImage(imageLiteralResourceName: "sony_playstation5")])
        let sonyPlaystation6 = Item(id: "2", name: "סוני פלייסטיישן", owner: "2b", category: "VideoGames",
                                      images: [UIImage(imageLiteralResourceName: "sony_playstation6")])
        return [sonyPlaystation1, sonyPlaystation2, sonyPlaystation3, sonyPlaystation4,
                sonyPlaystation5, sonyPlaystation6]
    }
}
