//
//  SearchItemViewController.swift
//  Barter POC
//
//  Created by Omer Derazon on 27/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit
import Hero

class ItemViewController: UIViewController {
    
    @IBOutlet var itemImage: ShadowRoundedImageView!
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    var item:Item?
    
    var itemsManagerDelegate:ItemsManagerDelegate?

    override func viewDidLoad() {
        itemImage.image = item?.images.first
        itemImage.shadowLayer.shadowOffset = CGSize(width: 10, height: 6)
        itemImage.layer.cornerRadius = 5
        itemImage.layer.borderWidth = 0.5
        itemImage.layer.borderColor = UIColor.lightGray.cgColor
        
        itemTitleLabel.text = item?.name
        likeButton.setTitleColor(.black, for: .normal)
        likeButton.layer.cornerRadius = 5
        likeButton.layer.borderColor = UIColor.systemGreen.cgColor
        likeButton.layer.borderWidth = 1
        likeButton.setTitle("שלח הצעה", for: .normal)
    }
    
    @IBAction func likeClick(_ sender: Any) {
        self.dismiss(animated: true) {
            self.itemsManagerDelegate?.likedItem(item: self.item!)
        }
    }
}
