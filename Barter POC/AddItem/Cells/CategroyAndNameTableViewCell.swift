//
//  CategroyAndNameCollectionViewCell.swift
//  Barter POC
//
//  Created by Omer Derazon on 29/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

protocol TitleAndCategoryEditingDelegate {
    func provideItemTitle() -> String?
    func provideItemCategory(itemCategory:String)
}

class CategroyAndNameTableViewCell:UITableViewCell, TitleAndCategoryEditingDelegate, UITextFieldDelegate {

    @IBOutlet var itemTitleTextField: UITextField!
    
    func set() {
        itemTitleTextField.delegate = self
    }
    
    func provideItemTitle() -> String? {
        return itemTitleTextField.text
    }
    
    func provideItemCategory(itemCategory: String) {
        
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        itemTitleTextField.endEditing(true)
    }
}

