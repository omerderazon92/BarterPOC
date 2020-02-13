//
//  WinningPickItemViewController.swift
//  Barter POC
//
//  Created by Omer Derazon on 31/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class WinningPickItemViewController: UIViewController {

    @IBOutlet var winningPickItemVIewColletionView: UICollectionView!
    var potentialDeals:[Deal]? {
        didSet {
            
        }
    }
    override func viewDidLoad() {
        winningPickItemVIewColletionView.delegate = self
        winningPickItemVIewColletionView.dataSource = self
    }
}

extension WinningPickItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return potentialDeals?.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if (potentialDeals?.count == nil) {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyOffersCollectionViewCell", for: indexPath) as! EmptyOffersCollectionViewCell
//            return cell
//        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCollectionViewCell", for: indexPath) as! OffersCollectionViewCell
        cell.set()
        return cell
    }
}

extension WinningPickItemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if (indexPath.item == 0) {
//            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//        }
        
        return CGSize(width: view.frame.width / 1.05, height: view.frame.height / 7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
    }
}
