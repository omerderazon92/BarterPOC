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
    func deleteImage(collectionViewCell: UICollectionViewCell)
    func addImage(image:UIImage)
    func provideImages() -> [UIImage]
}

class ImageAddingTableViewCell:UITableViewCell, ImagesEditingDelegate {

    @IBOutlet var addImageCollectionView: UICollectionView!
    @IBOutlet var imageNumberLabel: UILabel!
    var cameraDelegate:CameraDelegate?
    var images:[UIImage] = [UIImage()]
    
    func deleteImage(collectionViewCell: UICollectionViewCell) {
        guard let indexPath = addImageCollectionView.indexPath(for: collectionViewCell) else {
            return
        }
        images.remove(at: indexPath.item)
        addImageCollectionView.reloadData()
    }
    
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
    @IBOutlet var xImage: UIImageView!
    
    var cameraDelegate: CameraDelegate?
    
    func setImage(image:UIImage) {
        letsUploadLabel.isHidden = true
        itemImage.isHidden = false
        itemImage.image = image
    }
    
    func set() {
        itemImage.isHidden = true
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 10
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ButtonCell.uploadImage))
        letsUploadLabel.addGestureRecognizer(tapGesture)
        letsUploadLabel.isUserInteractionEnabled = true
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(ButtonCell.deleteImage))
        xImage.addGestureRecognizer(tapGesture2)
        xImage.isUserInteractionEnabled = true
    }
    
    @objc func uploadImage() {
        cameraDelegate?.openCamera()
    }
    
    @objc func deleteImage() {
        cameraDelegate?.deleteImage(collectionViewCell: self)
    }
}
