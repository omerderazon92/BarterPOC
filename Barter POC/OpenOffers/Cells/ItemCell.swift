//
//  ItemCell.swift
//  Barter POC
//
//  Created by Omer Derazon on 09/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class ItemCell: UICollectionViewCell {
   
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    var item:Item? {
        didSet {
            
        }
    }

    var delegate:ItemsManagerDelegate?
    
    func set() {
        if let itemWanted = item?.wanted {
            if itemWanted {
                itemImage.layer.borderWidth = 1.5
                itemImage.layer.borderColor = UIColor.systemGreen.cgColor
            } else {
                itemImage.layer.borderWidth = 0.7
                itemImage.layer.borderColor = UIColor.lightGray.cgColor
            }
        } else {
            itemImage.layer.borderWidth = 0.7
            itemImage.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        itemImage.image = item?.images.first
        itemImage.layer.cornerRadius = 10

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (ItemCell.imageTapped))
        itemImage.addGestureRecognizer(tapGesture)
        itemImage.isUserInteractionEnabled = true
        
        itemName.text = item?.name
                
        backgroundColor = .clear
    }
    
    @objc func imageTapped() {
        delegate?.moveToItemScreen(item: item!)
    }
}
