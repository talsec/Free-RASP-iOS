//
//  SpacerView.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 05/08/2021.
//

import UIKit

class SpacerView: UIView {
    static func make(height: CGFloat) -> SpacerView {
        return SpacerView(height: height)
    }

    static func make() -> SpacerView {
        return SpacerView()
    }

    static func make(minHeight: CGFloat) -> SpacerView {
        return SpacerView(minHeight: minHeight)
    }

    init(height: CGFloat) {
        super.init(frame: .zero)
        backgroundColor = .clear
        set(height: height)
    }

    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
    }

    init(minHeight: CGFloat) {
        super.init(frame: .zero)
        backgroundColor = .clear
        heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight).isActive = true
    }

    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
    }

    required init?(coder _: NSCoder) {
        super.init(frame: .zero)
    }
}
