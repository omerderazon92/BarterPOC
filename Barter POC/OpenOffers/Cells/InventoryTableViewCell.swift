//
//  InventoryCollectionViewCell.swift
//  Barter POC
//
//  Created by Omer Derazon on 09/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class InventoryTableViewCell:UITableViewCell {
    
    @IBOutlet var itemsCollectionView: UICollectionView!
    @IBOutlet var inventoryName: UILabel!
    var delegate: ItemsManagerDelegate?
    var items:[Item]? {
        didSet {
            
        }
    }
    
    func set() {
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
        
        itemsCollectionView.showsHorizontalScrollIndicator = false
        itemsCollectionView.scrollToNearestVisibleCollectionViewCell()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        itemsCollectionView.collectionViewLayout = layout
        itemsCollectionView.isPagingEnabled = true
        
        inventoryName.text = "הפריטים של בודגי"
                
        let name = Notification.Name("didReceiveData")
        NotificationCenter.default.addObserver(self, selector: #selector(InventoryTableViewCell.itemChangedState), name: name, object: nil)        
    }
    
    @objc func itemChangedState() {
        itemsCollectionView.reloadData()
    }
}

extension InventoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemsCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.delegate = delegate
        cell.item = items![indexPath.item]
        cell.set()
        return cell
    }
}

extension InventoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2.5, left: 20, bottom: 2.5, right: 20)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSquareValue = collectionView.frame.width / 2.5
        let heightSquareValue = collectionView.frame.width / 2.2
        return CGSize(width: widthSquareValue, height: heightSquareValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
