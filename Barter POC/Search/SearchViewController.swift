//
//  ViewController.swift
//  Barter POC
//
//  Created by Omer Derazon on 27/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, ItemsManagerDelegate {

    @IBOutlet var searchCollectionVIew: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    private var items:[Item]? {
        didSet {
            searchCollectionVIew.reloadData()
        }
    }
    var presenter:SearchPresenterCapabilities?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCollectionVIew.delegate = self
        searchCollectionVIew.dataSource = self
        searchBar.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        searchCollectionVIew.setCollectionViewLayout(layout, animated: true)
        
        
    }

    func moveToItemScreen(item: Item) {
        guard let vc = storyboard?.instantiateViewController(identifier: "ItemViewController") as? ItemViewController else {
            return
        }
        vc.itemsManagerDelegate = self
        vc.item = item
        present(vc, animated: true, completion: nil)
    }
    
    func deleteItem(collectionViewCell: UICollectionViewCell) {
        guard let indexPath = searchCollectionVIew.indexPath(for: collectionViewCell) else {
            return
        }
        searchCollectionVIew.deleteItems(at: [indexPath])
        items?.remove(at: indexPath.item)
    }
    
    func likedItem(item: Item) {
        guard let vc = storyboard?.instantiateViewController(identifier: "GoodLuckViewController") as? GoodLuckViewController else {
            return
        }
        let title = "בהצלחה!"
        let details = "בקרוב בעל המוצר יקבל את ההודעה שלך. במידה ויאהב את אחד ממוצריך- אולי תוכלו להשלים את העסקה!"
        vc.set(title: title, details: details)
        present(vc, animated: true, completion: nil)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (items?.count == nil) {
            let cell = searchCollectionVIew.dequeueReusableCell(withReuseIdentifier: "BeforeSearchCollectionViewCell", for: indexPath) as! BeforeSearchCollectionViewCell
            return cell
        }
        let cell = searchCollectionVIew.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        cell.delegate = self
        cell.item = items![indexPath.item]
        cell.set()
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2.0, left: 26.0, bottom: 2.0, right: 26.0)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSquareValue = collectionView.frame.width / 2.5
        let heightSquareValue = collectionView.frame.width / 2.0

        if (items == nil) {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        return CGSize(width: widthSquareValue, height: heightSquareValue)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        let child = SpinnerViewController()

           // add the spinner view controller
           addChild(child)
           child.view.frame = view.frame
           view.addSubview(child.view)
           child.didMove(toParent: self)

           // wait two seconds to simulate some work happening
           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
               // then remove the spinner view controller
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
                self.items = self.presenter?.fetchSearchResults()
           }
    }
}
