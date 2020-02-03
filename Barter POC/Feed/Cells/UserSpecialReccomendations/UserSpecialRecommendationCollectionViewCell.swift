//
//  UserSpecialRecommendationCollectionViewCell.swift
//  Barter POC
//
//  Created by Omer Derazon on 28/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class UserSpecialRecommendationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var itemImage: UIImageView!
    var delegate:ItemsManagerDelegate?
    var item:Item?
    
    func set(item: Item){
        self.item = item
        itemImage.image = item.images.first
        itemImage.layer.cornerRadius = 10
        layer.cornerRadius = 10
        layer.borderWidth = 0.7
        layer.borderColor = UIColor.lightGray.cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UserSpecialRecommendationCollectionViewCell.imageTapped))
              itemImage.addGestureRecognizer(tapGesture)
              itemImage.isUserInteractionEnabled = true
    }
    
    @objc func imageTapped() {
//        UIView.animate(withDuration: 0.1,
//        animations: {
//            self.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
//        },
//        completion: { _ in
//            UIView.animate(withDuration: 0.1, animations: {
//               self.transform = CGAffineTransform.identity
//            }) { (_) in
//                self.delegate?.moveToItemScreen(item: self.item!)
//            }
//        })
        bounceAndShine {
            self.delegate?.moveToItemScreen(item: self.item!)
            self.transform = CGAffineTransform.identity
        }
    }
}
