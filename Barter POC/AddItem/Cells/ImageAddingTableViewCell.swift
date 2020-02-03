//
//  ImageAddingCollectionViewCell.swift
//  Barter POC
//
//  Created by Omer Derazon on 29/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

protocol ImagesEditingDelegate {
    func addImage(image:UIImage)
    func provideImages() -> [UIImage]
}

class ImageAddingTableViewCell:UITableViewCell, ImagesEditingDelegate {

    @IBOutlet var addImageCollectionView: UICollectionView!
    @IBOutlet var imageNumberLabel: UILabel!
    var cameraDelegate:CameraDelegate?
    var images:[UIImage] = [UIImage()]
    
    func set() {
        imageNumberLabel.text = " התמונה הראשונה תהיה תמונת השער של הפוסט שלך"
        imageNumberLabel.text?.append(" \(images.count - 1)/3")

        addImageCollectionView.delegate = self
        addImageCollectionView.dataSource = self
        addImageCollectionView.showsHorizontalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        addImageCollectionView.collectionViewLayout = layout
    }

    func addImage(image:UIImage) {
        images.append(image)
        addImageCollectionView.reloadData()
        
        imageNumberLabel.text = " התמונה הראשונה תהיה תמונת השער של הפוסט שלך"
        imageNumberLabel.text?.append(" \(images.count - 1)/3")
    }
    
    func provideImages() -> [UIImage] {
        return images
    }
}

extension ImageAddingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
            cell.set()
            cell.cameraDelegate = cameraDelegate
            if(indexPath.item > 0){
                cell.setImage(image: images[indexPath.item])
            }
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 50, height: collectionView.frame.height - 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
    }
}

class ButtonCell: UICollectionViewCell {
        
    @IBOutlet var letsUploadLabel: UILabel!
    @IBOutlet var itemImage: UIImageView!
    
    var cameraDelegate: CameraDelegate?
    
    func setImage(image:UIImage) {
        letsUploadLabel.isHidden = true
        itemImage.isHidden = false
        itemImage.image = image
    }
    
    func set() {
        itemImage.isHidden = true
        layer.borderWidth = 1
        layer.cornerRadius = 5
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ButtonCell.uploadImage))
        letsUploadLabel.addGestureRecognizer(tapGesture)
        letsUploadLabel.isUserInteractionEnabled = true
    }
    
    @objc func uploadImage() {
        cameraDelegate?.openCamera()
    }
}
