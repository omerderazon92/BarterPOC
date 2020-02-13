//
//  MyItemsViewController.swift
//  Barter POC
//
//  Created by Omer Derazon on 06/02/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class MyItemsViewController: UIViewController, ItemsManagerDelegate {
        
    @IBOutlet var myItemsCollectionView: UICollectionView!
    var presenter:MyItemsPresenterCapabilities?
    
    private var items:[Item]? {
        didSet {
            myItemsCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = presenter?.fetchItems()
        myItemsCollectionView.delegate = self
        myItemsCollectionView.dataSource = self
        myItemsCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        myItemsCollectionView.setCollectionViewLayout(layout, animated: true)
        
        title = "פריטיי" 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myItemsCollectionView.reloadData()
        let numberOfCurrentOffers = presenter?.fetchNumberOfCurrentOffers()
        tabBarController?.tabBar.items![3].badgeValue = numberOfCurrentOffers! > 0 ? numberOfCurrentOffers!.description : nil
    }
    
    func moveToItemScreen(item: Item) {
        guard let vc = storyboard?.instantiateViewController(identifier: "ItemDetailsViewController") as? ItemDetailsViewController else {
            return
        }
        vc.item = item
        navigationController?.hero.isEnabled = true
        navigationController?.hero.navigationAnimationType = .autoReverse(presenting: .slide(direction: .up))
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func likedItem(item: Item) {
        
    }
    
    func deleteItemWithCell(collectionViewCell: UICollectionViewCell) {
        
    }
    
    func deleteItemWithItem(item: Item) {
        
    }
}

extension MyItemsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myItemsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyItemCollectionViewCell", for: indexPath) as! MyItemCollectionViewCell
        cell.delegate = self
        cell.item = items![indexPath.item]
        cell.set()
        return cell
    }
}

extension MyItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2.0, left: 26.0, bottom: 2.0, right: 26.0)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSquareValue = collectionView.frame.width / 2.5
        let heightSquareValue = collectionView.frame.width / 2.0
        return CGSize(width: widthSquareValue, height: heightSquareValue)
    }
}
