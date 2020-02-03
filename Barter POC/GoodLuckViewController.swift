//
//  GoodLuckViewController.swift
//  Barter POC
//
//  Created by Omer Derazon on 28/01/2020.
//  Copyright © 2020 Omer Derazon. All rights reserved.
//

import Foundation
import UIKit

class GoodLuckViewController:UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    private var starsColor:UIColor?
    private var titleLabelText:String?
    private var detailsLabelText:String?
    
    func set(title: String, details: String, starsColor: UIColor = UIColor.yellow) {
        titleLabelText = title
        detailsLabelText = details
        self.starsColor = starsColor
    }
    
    override func viewDidLoad() {
        titleLabel.text = titleLabelText
        detailsLabel.text = detailsLabelText
        createParticles()
    }
    
    func createParticles() {
        let particleEmitter = CAEmitterLayer()

        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -96)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)

        let yellow = makeEmitterCell(color: starsColor ?? UIColor.yellow)

        particleEmitter.emitterCells = [yellow, yellow]

        view.layer.addSublayer(particleEmitter)
    }

    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 200
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05

        cell.contents = UIImage(named: "particle_confetti")?.cgImage
        return cell
    }
}
