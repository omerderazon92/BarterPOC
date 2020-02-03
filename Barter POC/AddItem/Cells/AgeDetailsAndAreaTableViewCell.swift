//
//  AgeDetailsAndAreaCollectionViewCell.swift
//  Barter POC
//
//  Created by Omer Derazon on 29/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

protocol AgeDetailsAndAreaDelegate {
    func provideItemAge() -> String?
}

class AgeDetailsAndAreaTableViewCell:UITableViewCell, AgeDetailsAndAreaDelegate, UITextFieldDelegate {

    @IBOutlet var ageTextField: UITextField!
    
    func set() {
        ageTextField.delegate = self
    }
    
    func provideItemAge() -> String? {
        return ageTextField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ageTextField.endEditing(true)
    }    
}
