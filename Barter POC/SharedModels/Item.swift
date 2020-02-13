//
//  Item.swift
//  Barter POC
//
//  Created by Omer Derazon on 01/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class Item {
    let id:String
    let name:String
    let owner:String
    let category:String
    let images:[UIImage]
    
    var wanted:Bool?
    var currentOffers:[Offer]?
    
    init(id:String, name:String, owner:String, category: String, images:[UIImage],
         wanted: Bool? = nil,
         currentOffers:[Offer]? = nil) {
        self.id = id
        self.name = name
        self.owner = owner
        self.category = category
        self.images = images
        self.wanted = wanted
        self.currentOffers = currentOffers
    }    
}

class Offer {
    let owner:String
    var ownerInventory:[Item]?
    
    init(owner: String, ownerInventory: [Item]?) {
        self.owner = owner
        self.ownerInventory = ownerInventory
    }
}
