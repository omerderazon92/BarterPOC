//
//  WinningPickItemViewController.swift
//  Barter POC
//
//  Created by Omer Derazon on 31/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class WinningPickItemViewController: UIViewController {
   
    @IBOutlet var numberOfPresentsLabel: UILabel!
    @IBOutlet var details: UILabel!
    @IBOutlet var instructionsLabel: UILabel!
    
    override func viewDidLoad() {
        numberOfPresentsLabel.text = "כל יום פורים!"
        details.text = "מחכים לך 36 מוצרים שיכולים להיות שלך, איזה כיף."
        instructionsLabel.text = "שקשק כדי לגלות"
        let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (_) in
            self.instructionsLabel.shake()
        }
    }
    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }

    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let vc = storyboard?.instantiateViewController(identifier: "GoodLuckViewController") as! GoodLuckViewController
            let title = "ברכות, מישהו אהב את הקורקינט שלך!"
            let details = "מיד יוצגו בפניך 5 פריטים שיכולים להיות שלך. קח כיסא, תרגע ותהנה :)"
            vc.set(title: title, details: details, starsColor: UIColor.cyan)
            present(vc, animated: true, completion: {
                let _ = Timer.scheduledTimer(withTimeInterval: 7.0, repeats: false) { _ in
                vc.dismiss(animated: true, completion: nil)
                }
            })
        }
    }

}


