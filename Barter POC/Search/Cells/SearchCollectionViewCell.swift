//
//  SearchCollectionViewCell.swift
//  Barter POC
//
//  Created by Omer Derazon on 27/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class SearchCollectionViewCell:UICollectionViewCell {
    
    private var isClicked = false
    var delegate:ItemsManagerDelegate?
    var item:Item?
    //Viewz
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var declineButton: UIButton!
    //Constraints
    @IBOutlet var itemNameBottomConstraint: NSLayoutConstraint!
    @IBOutlet var likeButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet var declineButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet var likeButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet var declineButtonWidthConstraint: NSLayoutConstraint!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        closeClick(withAnimation: false)
    }
    
    func set() {
        //Set Image
        itemImage.image = item?.images.first
        itemImage.layer.cornerRadius = 10
        itemImage.layer.borderWidth = 0.7
        itemImage.layer.borderColor = UIColor.lightGray.cgColor
        //Bring buttons to back
        likeButton.superview?.sendSubviewToBack(likeButton)
        declineButton.superview?.sendSubviewToBack(declineButton)
        // Listeners
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SearchCollectionViewCell.imageTapped))
        itemImage.addGestureRecognizer(tapGesture)
        itemImage.isUserInteractionEnabled = true
        //Set buttons
        likeButtonWidthConstraint.constant = frame.width / 2.1
        declineButtonWidthConstraint.constant = frame.width / 2.1
        declineButton.setTitleColor(.black, for: .normal)
    }
    
    @objc func imageTapped() {
        isClicked = !isClicked
        isClicked == true ? openClick() : closeClick()
    }
    
    @IBAction func likedButtonClick(_ sender: Any) {
        delegate?.moveToItemScreen(item: item!)
    }
    
    @IBAction func deleteButtonClick(_ sender: Any) {
        animateThis(animation: {
            self.alpha = 0
        }, duration: 0.5) { _ in
            self.delegate?.deleteItemWithCell(collectionViewCell: self)
        }
    }
}

extension SearchCollectionViewCell {
    private func openClick(withAnimation:Bool = true) {
        itemName.superview?.sendSubviewToBack(itemName)
        itemNameBottomConstraint.constant = 100
        animateConstraintChanges(with: { _ in
            self.likeButtonBottomConstraint.constant = 15
            self.declineButtonBottomConstraint.constant = 15
            self.animateConstraintChanges(with: nil, duration: 0.3)
        }, duration: 0.3)
    }
    
    private func closeClick(withAnimation:Bool = true) {
        likeButtonBottomConstraint.constant = 50
        declineButtonBottomConstraint.constant = 150
        animateConstraintChanges(with: { _ in
            self.itemNameBottomConstraint.constant = 25
            self.animateConstraintChanges(with: nil, duration: 0.3)
        }, duration: 0.3)
    }
    
    private func animateConstraintChanges(with completion:((Bool)->(Void))?, duration: Double, delay: Double = 0) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: completion)
    }
    
    private func animateThis(animation: @escaping () -> (), duration:Double, completion: ((Bool) -> (Void))?) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: animation, completion: completion)
    }
}
