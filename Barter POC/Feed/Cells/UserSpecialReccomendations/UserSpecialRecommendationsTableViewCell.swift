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
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        userSpecialReccomendationCollectionView.collectionViewLayout = layout

        categoryNameLabel.text = ("\(category?.name ?? "")")
        let name = Notification.Name("fixUserReccomendationsCollectionViewPlacing")
        NotificationCenter.default.addObserver(self, selector: #selector(self.fixCollectionViewPlacing), name: name, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteItem(_:)), name: NSNotification.Name(rawValue: "deleteSpecialRecommendationItem"), object: nil)
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
        
    @objc func fixCollectionViewPlacing() {
        userSpecialReccomendationCollectionView.scrollToNearestVisibleCollectionViewCell()
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
        return UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightSquareValue = collectionView.frame.width * 0.30

        return CGSize(width: heightSquareValue, height: heightSquareValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
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
