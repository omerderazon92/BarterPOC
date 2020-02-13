//
//  AddItemViewController.swift
//  Barter POC
//
//  Created by Omer Derazon on 29/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

protocol CameraDelegate {
    func openCamera()
    func deleteImage(collectionViewCell: UICollectionViewCell)
}

class AddItemViewController: UIViewController {

    @IBOutlet var addItemTableView: UITableView!
    var imageEditingDelegate:ImagesEditingDelegate?
    var titleAndCategoryEditingDelegate:TitleAndCategoryEditingDelegate?
    var ageDetailsAndAreaDelegate:AgeDetailsAndAreaDelegate?
    
    override func viewDidLoad() {
        addItemTableView.delegate = self
        addItemTableView.dataSource = self
        addItemTableView.separatorStyle = .none
        hideKeyboardWhenTappedAround()
        addItemTableView.alwaysBounceVertical = false
//        addItemTableView.isScrollEnabled = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "הבא", style: .done, target: self, action: #selector(action(sender:)))
        title = "הוסף"
    }
    
    @objc func action(sender: UIBarButtonItem) {
        // Function body goes here
    }
}

extension AddItemViewController: CameraDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera() {
        let alert = UIAlertController(title: "מאיפה ניקח את התמונה?", message: "חביבי", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "אלבום", style: .default, handler: { (_) in
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.allowsEditing = true
            vc.delegate = self
            self.present(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "מצלמה", style: .default, handler: { (_) in
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.delegate = self
            self.present(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: { (_) in
        }))

        present(alert, animated: true, completion: nil)
    }
    
    func deleteImage(collectionViewCell: UICollectionViewCell) {
        imageEditingDelegate?.deleteImage(collectionViewCell: collectionViewCell)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        imageEditingDelegate?.addImage(image: image)
    }
}

extension AddItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageAddingTableViewCell", for: indexPath) as! ImageAddingTableViewCell
            cell.cameraDelegate = self
            cell.set()
            imageEditingDelegate = cell
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategroyAndNameTableViewCell", for: indexPath) as! CategroyAndNameTableViewCell
            cell.set()
            titleAndCategoryEditingDelegate = cell
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgeDetailsAndAreaTableViewCell", for: indexPath) as! AgeDetailsAndAreaTableViewCell
            ageDetailsAndAreaDelegate = cell
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgeDetailsAndAreaTableViewCell", for: indexPath) as! AgeDetailsAndAreaTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return tableView.frame.height / 2.2
        } else if indexPath.item == 1 {
            return tableView.frame.height / 2
        }
        return tableView.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
