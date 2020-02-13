//
//  ItemDetailsViewController.swift
//  Barter POC
//
//  Created by Omer Derazon on 06/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class ItemDetailsViewController: UIViewController {
    
    @IBOutlet var itemTitleLabel: UILabel!
    @IBOutlet var itemImage: ShadowRoundedImageView!
    @IBOutlet var openOffersButton: UIButton!
    static var id:Int = 1
    static var idForLabel:Int = 1
    var item:Item?
    
    override func viewDidLoad() {
        itemImage.shadowLayer.opacity = 0
        itemImage.hero.id = ItemViewController.id.description
        itemTitleLabel.hero.id = ItemViewController.idForLabel.description
        itemImage.image = item?.images.first
        itemImage.layer.cornerRadius = 10
        itemImage.layer.borderWidth = 0.5
        itemImage.layer.borderColor = UIColor.lightGray.cgColor
        
        itemTitleLabel.text = item?.name
        
        openOffersButton.isHidden = ((item?.currentOffers) == nil || (item?.currentOffers!.isEmpty)!)
    }
    
    @IBAction func openOffers(_ sender: Any) {        
        let vc = storyboard?.instantiateViewController(identifier: "OpenOffersViewController") as! OpenOffersViewController
        vc.item = item
        navigationController?.pushViewController(vc, animated: true)
    }
}
