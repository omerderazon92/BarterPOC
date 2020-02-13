//
//  BestRecommendationTableViewCell.swift
//  Barter POC
//
//  Created by Omer Derazon on 28/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class BestRecommendationTableViewCell: UITableViewCell {

    @IBOutlet var bestReccomendedItamesCollectionView: UICollectionView!
    var delegate:ItemsManagerDelegate?
    var presenter: BestRecommendationsPresenterCapabilities?
    
    var items:[Item]? {
        didSet {
            bestReccomendedItamesCollectionView.reloadData()
        }
    }
    
    func set() {
        setGradientBackground(colorOne: UIColor.white, colorTwo: UIColor.lightGray)
        bestReccomendedItamesCollectionView.backgroundColor = .clear
        bestReccomendedItamesCollectionView.delegate = self
        bestReccomendedItamesCollectionView.dataSource = self
        bestReccomendedItamesCollectionView.showsHorizontalScrollIndicator = false
        bestReccomendedItamesCollectionView.isPagingEnabled = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        bestReccomendedItamesCollectionView.collectionViewLayout = layout
    
        items = presenter?.fetchRecommendations()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteItem(_:)), name: NSNotification.Name(rawValue: "deleteBestRecommendationItem"), object: nil)
    }
    
    @objc func deleteItem(_ notification: Notification) {
        if let item = notification.userInfo?["item"] as? Item {
            let indexFor = items?.firstIndex{$0 === item}
            guard let index = indexFor else {
                return
            }
            items?.remove(at: index)
        }
    }
}

extension BestRecommendationTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bestReccomendedItamesCollectionView.dequeueReusableCell(withReuseIdentifier: "BestRecommendedItemCollectionViewCell", for: indexPath) as! BestRecommendedItemCollectionViewCell
        cell.set(item: items![indexPath.item])
        cell.delegate = delegate
        return cell
    }
}

extension BestRecommendationTableViewCell: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bestReccomendedItamesCollectionView.frame.width * 0.98, height: bestReccomendedItamesCollectionView.frame.height)
    }
}

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 4.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
