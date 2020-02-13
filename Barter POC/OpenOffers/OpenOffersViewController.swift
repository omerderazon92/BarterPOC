//
//  OpenOffersViewController.swift
//  Barter POC
//
//  Created by Omer Derazon on 09/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class OpenOffersViewController: UIViewController, ItemsManagerDelegate {

    @IBOutlet var openOffersTableView: UITableView!
    @IBOutlet var placeHolderForTitle: UIView!
    var item:Item?
    
    override func viewDidLoad() {
        openOffersTableView.dataSource = self
        openOffersTableView.delegate = self
        openOffersTableView.separatorEffect = .none
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "שלח הצעות", style: .done, target: self, action: #selector(self.sendRequests))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        placeHolderForTitle.layer.borderWidth = 0.5
        placeHolderForTitle.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func moveToItemScreen(item: Item) {
        guard let vc = storyboard?.instantiateViewController(identifier: "ItemViewController") as? ItemViewController else {
            return
        }
        vc.itemsManagerDelegate = self
        vc.item = item
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func likedItem(item: Item) {
        if let itemWanted = item.wanted {
            item.wanted = !itemWanted
        } else {
            item.wanted = true
        }
        
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "didReceiveData")))
        navigationController?.popViewController(animated: true)
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    func deleteItemWithCell(collectionViewCell: UICollectionViewCell) {
        
    }
    
    func deleteItemWithItem(item: Item) {
        
    }
    
    @objc func sendRequests() {
        guard let vc = storyboard?.instantiateViewController(identifier: "GoodLuckViewController") as? GoodLuckViewController else {
            return
        }
        let title = "סלמתק!"
        let details = "בעל המוצר יקבל את הצעתך בעוד מספר שניות, מקווה שתוכלו להשלים את העסקה."
        vc.set(title: title, details: details, starsColor: .cyan)
        present(vc, animated: true) {
            self.item?.currentOffers = nil
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension OpenOffersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        item?.currentOffers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = openOffersTableView.dequeueReusableCell(withIdentifier: "InventoryTableViewCell") as! InventoryTableViewCell
        cell.delegate = self
        cell.set()
        cell.selectionStyle = .none
        cell.items = item?.currentOffers![indexPath.item].ownerInventory
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let tempOffer = item?.currentOffers?[indexPath.item] {
            if let inventorySize = tempOffer.ownerInventory?.count {
                if (inventorySize <= 2) {
                    return (tableView.frame.height / 1.3) / 1.8
                }
            }
        }
        return tableView.frame.height / 1.3
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
