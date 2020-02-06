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
    @IBOutlet var titleOfItemLabel: UILabel!
    var delegate:ItemsManagerDelegate?
    private var item:Item?
    
    func set(item:Item){
        self.item = item

        backgroundColor = .clear
        itemImage.image = item.images.first
        itemImage.shadowLayer.shadowOffset = CGSize(width: 10, height: 6)
        itemImage.layer.cornerRadius = 10
        itemImage.layer.borderWidth = 0.5
        itemImage.layer.borderColor = UIColor.lightGray.cgColor

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UserSpecialRecommendationCollectionViewCell.imageTapped))
        itemImage.addGestureRecognizer(tapGesture)
        itemImage.isUserInteractionEnabled = true
        
        titleOfItemLabel.textColor = .white
        titleOfItemLabel.text = self.item?.name
    }
    
    @objc func imageTapped() {
        bounceAndShine(completion: {
            self.delegate?.moveToItemScreen(item: self.item!)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
               self.transform = CGAffineTransform.identity
            }
        })
    }
}
