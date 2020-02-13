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

class CategroyAndNameTableViewCell:UITableViewCell, TitleAndCategoryEditingDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet var itemTitleTextField: UITextField!
    @IBOutlet var itemCategoryTextField: UITextField!
    @IBOutlet var itemDescriptionTextView: UITextView!
    
    func set() {
        itemTitleTextField.delegate = self
        itemDescriptionTextView.delegate = self
        itemCategoryTextField.delegate = self
        
        itemDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        itemDescriptionTextView.layer.cornerRadius = 10
        itemDescriptionTextView.layer.borderWidth = 0.5
        itemDescriptionTextView.text = "פרטים נוספים"
        itemDescriptionTextView.textColor = UIColor.lightGray
    }
    
    func provideItemTitle() -> String? {
        return itemTitleTextField.text
    }
    
    func provideItemCategory(itemCategory: String) {
        
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == itemTitleTextField) {
            itemTitleTextField.endEditing(true)
        } else if (textField == itemCategoryTextField) {
            itemCategoryTextField.endEditing(true)
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "פרטים נוספים"
            textView.textColor = UIColor.lightGray
        }
    }
}

