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
        bestReccomendedItamesCollectionView.scrollToNearestVisibleCollectionViewCell()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        bestReccomendedItamesCollectionView.collectionViewLayout = layout
    
        items = presenter?.fetchRecommendations()
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
        return CGSize(width: bestReccomendedItamesCollectionView.frame.width, height: bestReccomendedItamesCollectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.bestReccomendedItamesCollectionView.scrollToNearestVisibleCollectionViewCell()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.bestReccomendedItamesCollectionView.scrollToNearestVisibleCollectionViewCell()
        }
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
