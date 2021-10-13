//
//  GradientView.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 05/08/2021.
//

import UIKit

final class GradientView: UIView {

    var startColor: UIColor? = .black { didSet { updateColors() } }
    var endColor: UIColor? = .white { didSet { updateColors() } }
    var startLocation: Double = 0.05 { didSet { updateLocations() } }
    var endLocation: Double = 0.95 { didSet { updateLocations() } }
    var horizontalMode: Bool = false { didSet { updatePoints() } }
    var diagonalMode: Bool = false { didSet { updatePoints() } }

    override class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer? { layer as? CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer?.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
            gradientLayer?.endPoint = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer?.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
            gradientLayer?.endPoint = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
        }
    }

    func updateLocations() {
        gradientLayer?.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }

    func updateColors() {
        gradientLayer?.colors = [startColor?.cgColor ?? UIColor.black.cgColor,
                                 endColor?.cgColor ?? UIColor.black.cgColor]
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
