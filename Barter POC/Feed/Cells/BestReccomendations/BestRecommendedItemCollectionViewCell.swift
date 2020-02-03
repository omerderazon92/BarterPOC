//
//  BestRecommendedItemCollectionViewCell.swift
//  Barter POC
//
//  Created by Omer Derazon on 28/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit
import Hero

class BestRecommendedItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var itemImage: ShadowRoundedImageView!
    var delegate:ItemsManagerDelegate?
    private var item:Item?

    func set(item:Item){
        backgroundColor = .clear
        itemImage.image = item.images.first
        itemImage.shadowLayer.shadowOffset = CGSize(width: 10, height: 6)
        itemImage.layer.cornerRadius = 5
        itemImage.layer.borderWidth = 0.5
        itemImage.layer.borderColor = UIColor.lightGray.cgColor

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UserSpecialRecommendationCollectionViewCell.imageTapped))
        itemImage.addGestureRecognizer(tapGesture)
        itemImage.isUserInteractionEnabled = true
        
        self.item = item
    }
        
    @objc func imageTapped() {
        delegate?.moveToItemScreen(item: item!)
    }
}
