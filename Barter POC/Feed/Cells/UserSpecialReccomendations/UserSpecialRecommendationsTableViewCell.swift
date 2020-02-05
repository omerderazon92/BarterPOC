//
//  UserSpecialRecommendationsCollectionViewCell.swift
//  Barter POC
//
//  Created by Omer Derazon on 28/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class UserSpecialRecommendationsTableViewCell: UITableViewCell {
    
    @IBOutlet var userSpecialReccomendationCollectionView: UICollectionView!
    @IBOutlet var categoryNameLabel: UILabel!
    var delegate:ItemsManagerDelegate?
    var category:Category?
    var presenter:UserSpecialRecommendationsPresenterCapabilities?
    
    var items:[Item]? {
        didSet {
            userSpecialReccomendationCollectionView.reloadData()
        }
    }
    
    func set() {
        items = presenter?.fetchSpecialRecommendations(with: category ?? Category(id: "0", name: "SomeDefaultCategory", subName: nil))
        userSpecialReccomendationCollectionView.delegate = self
        userSpecialReccomendationCollectionView.dataSource = self
        userSpecialReccomendationCollectionView.showsHorizontalScrollIndicator = false
        userSpecialReccomendationCollectionView.scrollToNearestVisibleCollectionViewCell()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        userSpecialReccomendationCollectionView.collectionViewLayout = layout

        categoryNameLabel.text = ("\(category?.name ?? "")")
    }
}

extension UserSpecialRecommendationsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserSpecialRecommendationCollectionViewCell", for: indexPath) as! UserSpecialRecommendationCollectionViewCell
        cell.set(item: items![indexPath.item])
        cell.delegate = delegate
        return cell
        
    }
}

extension UserSpecialRecommendationsTableViewCell: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightSquareValue = collectionView.frame.width / 3.2

        return CGSize(width: heightSquareValue, height: heightSquareValue)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.userSpecialReccomendationCollectionView.scrollToNearestVisibleCollectionViewCell()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.userSpecialReccomendationCollectionView.scrollToNearestVisibleCollectionViewCell()
        }
    }
}
