//
//  ShadowRoundedImageView.swift
//  Barter POC
//
//  Created by Omer Derazon on 27/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class ShadowRoundedImageView: UIView {
    @IBInspectable var image: UIImage? = nil {
        didSet {
            imageLayer.contents = image?.cgImage
            shadowLayer.shadowPath = (image == nil) ? nil : shapeAsPath }}

    var imageLayer: CALayer = CALayer()
    var shadowLayer: CALayer = CALayer()

    var shape: UIBezierPath {
        return UIBezierPath(roundedRect: bounds, cornerRadius:5) }

    var shapeAsPath: CGPath {
        return shape.cgPath }

    var shapeAsMask: CAShapeLayer {
        let s = CAShapeLayer()
        s.path = shapeAsPath
        return s }

    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = false
        backgroundColor = .clear

        self.layer.addSublayer(shadowLayer)
        self.layer.addSublayer(imageLayer) // (in that order)

        imageLayer.frame = bounds
        imageLayer.contentsGravity = .resizeAspectFill // (as preferred)

        imageLayer.mask = shapeAsMask
        shadowLayer.shadowPath = (image == nil) ? nil : shapeAsPath
        shadowLayer.shadowOpacity = 0.15 // etc ...
    }
}
