//
//  Extensions.swift
//  Barter POC
//
//  Created by Omer Derazon on 29/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

public extension UIView {
    func shake(count : Float = 4,for duration : TimeInterval = 0.4,withTranslation translation : Float = 3) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}

extension UIView {
    
    func bounceAndShine(completion: (() -> ())?) {
        let shiningView:UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.alpha = 0.13
            return view
        }()
        
        addSubview(shiningView)
        shiningView.translatesAutoresizingMaskIntoConstraints = false
        shiningView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        shiningView.leftAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        shiningView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        shiningView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        shiningView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        UIView.animate(withDuration: 0.1, animations: {
            self.layoutIfNeeded()
            self.transform = CGAffineTransform(scaleX: 1.04, y: 1.04)
        }) { (_) in
            UIView.animate(withDuration: 0.07, animations: {
                self.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
            }) { (_) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.transform = CGAffineTransform(scaleX: 1.04, y: 1.04)
                }, completion: { _ in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.layoutIfNeeded()
                    }) { (_) in
                        shiningView.rightAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
                        UIView.animate(withDuration: 0.2, animations: {
                            self.layoutIfNeeded()
                        }) { (_) in
                            completion!()
                        }
                    }
                })
            }
        }
    }
}
