//
//  OffersCollectionViewCell.swift
//  Barter POC
//
//  Created by Omer Derazon on 08/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class OffersCollectionViewCell: UICollectionViewCell {
       
    @IBOutlet var itemImage: ShadowRoundedImageView!
    
    func set() {
        layer.cornerRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        itemImage.image = UIImage(imageLiteralResourceName: "sony_playstation")        
    }
}
