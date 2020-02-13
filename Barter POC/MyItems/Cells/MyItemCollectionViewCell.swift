//
//  MyItemCollectionViewCell.swift
//  Barter POC
//
//  Created by Omer Derazon on 06/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class MyItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var numberOfOffersLabel: UILabel!
    let notificationView = UIView()

    var delegate: ItemsManagerDelegate?
    var item:Item?
    
    func set() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MyItemCollectionViewCell.imageTapped))
        itemImage.addGestureRecognizer(tapGesture)
        itemImage.isUserInteractionEnabled = true
        
        backgroundColor = .clear
        itemImage.image = item?.images.first
        itemName.text = item?.name
        
        itemImage.layer.cornerRadius = 10
        itemImage.layer.borderWidth = 0.7
        itemImage.layer.borderColor = UIColor.lightGray.cgColor
        
//        notificationView.frame = CGRect(x: 0, y: 0, width: 60 , height: 60)
//        notificationView.layer.cornerRadius = 10
//        notificationView.backgroundColor = .systemRed
//        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 30, startAngle: 0.0, endAngle: .pi, clockwise: true)
//        let circleShape = CAShapeLayer()
//        circleShape.path = circlePath.cgPath
//        notificationView.layer.mask = circleShape  
//        itemImage.addSubview(notificationView)
        
        numberOfOffersLabel.text = item?.currentOffers?.count.description
        numberOfOffersLabel.textColor = .red
    }
    
    @objc func imageTapped() {
         let generatedString = Int.random(in: 1...1500)
         self.itemImage.hero.id = generatedString.description
         ItemViewController.id = generatedString

         let generatedString2 = Int.random(in: 1...1500)
         self.itemName.hero.id = generatedString2.description
         ItemViewController.idForLabel = generatedString2

        
        smallBounce(completion: {
            self.delegate?.moveToItemScreen(item: self.item!)
            self.transform = .identity
        })
    }
}
