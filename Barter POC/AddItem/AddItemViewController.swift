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

    }
    
    @objc func action(sender: UIBarButtonItem) {
        // Function body goes here
    }
}

extension AddItemViewController: CameraDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera() {
        let vc = UIImagePickerController()
         vc.sourceType = .camera
         vc.allowsEditing = true
         vc.delegate = self
         present(vc, animated: true)
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
            return tableView.frame.height / 7
        }
        return tableView.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
