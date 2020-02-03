//
//  FeedViewController.swift
//  Barter POC
//
//  Created by Omer Derazon on 28/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

protocol ItemsManagerDelegate {
    func moveToItemScreen(item:Item)
    func likedItem(item: Item)
    func deleteItem(collectionViewCell: UICollectionViewCell)
}

class FeedViewController:UIViewController, ItemsManagerDelegate {

    @IBOutlet var feedTableView: UITableView!
    var presenter: FeedPresenterCapabilities?
    var categories:[Category]? {
        didSet {
            feedTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.separatorStyle = .none

        categories = presenter?.fetchCaegories()
    }
    
    func moveToItemScreen(item:Item) {
        guard let vc = storyboard?.instantiateViewController(identifier: "ItemViewController") as? ItemViewController else {
            return
        }
        vc.itemsManagerDelegate = self
        vc.item = item
        present(vc, animated: true, completion: nil)
    }
    
    func likedItem(item: Item) {
        guard let vc = storyboard?.instantiateViewController(identifier: "GoodLuckViewController") as? GoodLuckViewController else {
            return
        }
        let title = "בהצלחה!"
        let details = "בקרוב בעל המוצר יקבל את ההודעה שלך. במידה ויאהב את אחד ממוצריך- אולי תוכלו להשלים את העסקה!"
        vc.set(title: title, details: details)
        present(vc, animated: true, completion: {
            let _ = Timer.scheduledTimer(withTimeInterval: 7, repeats: false) { (_) in
                vc.dismiss(animated: true, completion: nil)
            }
        })
    }

    func deleteItem(collectionViewCell: UICollectionViewCell) {
        
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (categories?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.item == 0){
            let cell = feedTableView.dequeueReusableCell(withIdentifier: "BestRecommendationTableViewCell", for: indexPath) as! BestRecommendationTableViewCell
            cell.presenter = BestRecommendationsPresenter()
            cell.set()
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = feedTableView.dequeueReusableCell(withIdentifier: "UserSpecialRecommendationsTableViewCell", for: indexPath) as! UserSpecialRecommendationsTableViewCell
            cell.category = categories![indexPath.item - 1]
            cell.presenter = UserSpecialRecommendationsPresenter()
            cell.set()
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 2.3
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
