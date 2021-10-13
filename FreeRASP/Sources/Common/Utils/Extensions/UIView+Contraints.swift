//
//  UIView+Contraints.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 05/08/2021.
//

import UIKit

struct ConstraintsPriorities {
    let top: CGFloat
    let bottom: CGFloat
    let left: CGFloat
    let right: CGFloat

    init(top: CGFloat = 1000, bottom: CGFloat = 1000, left: CGFloat = 1000, right: CGFloat = 1000) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }
}

extension UIEdgeInsets {
    init(top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }

    init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    static var horizontal = UIEdgeInsets(horizontal: 10)
}

extension UIView {

    func addSubviewWithConstraints(_ view: UIView, insets: UIEdgeInsets = UIEdgeInsets(), constraintsPriorities: ConstraintsPriorities = ConstraintsPriorities()) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setConstraints(view, insets: insets, constraintsPriorities: constraintsPriorities)
    }

    func setConstraints(_ view: UIView, insets: UIEdgeInsets = UIEdgeInsets(), constraintsPriorities: ConstraintsPriorities = ConstraintsPriorities()) {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(left@leftPriority)-[view]-(right@rightPriority)-|", options: [], metrics: ["left": insets.left, "leftPriority": constraintsPriorities.left, "right": insets.right, "rightPriority": constraintsPriorities.right], views: ["view": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(top@topPriority)-[view]-(bottom@bottomPriority)-|", options: [], metrics: ["top": insets.top, "topPriority": constraintsPriorities.top, "bottom": insets.bottom, "bottomPriority": constraintsPriorities.bottom], views: ["view": view]))
    }

    func addSubviewWithConstraintsToSafeArea(_ view: UIView, insets: UIEdgeInsets = UIEdgeInsets()) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setConstraintsToSafeArea(view, insets: insets)
    }

    func setConstraintsToSafeArea(_ view: UIView, insets: UIEdgeInsets = UIEdgeInsets()) {
        view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: insets.top).isActive = true
        view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -1 * insets.bottom).isActive = true
        view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: insets.left).isActive = true
        view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -1 * insets.right).isActive = true
    }

    func addSubviewWithConstraintsAsCentered(_ view: UIView, insets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setConstraintsAsCentered(view, insets: insets)
    }

    func setConstraintsAsCentered(_ view: UIView, insets: UIEdgeInsets = .zero) {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|->=top-[view]->=bottom-|", options: [], metrics: ["top": insets.top, "bottom": insets.bottom], views: ["view": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|->=left-[view]->=right-|", options: [], metrics: ["left": insets.left, "right": insets.right], views: ["view": view]))
        addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
    }

    func addSubviewHorizontallyCentered(_ view: UIView, insets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[view]-bottom-|", options: [], metrics: ["top": insets.top, "bottom": insets.bottom], views: ["view": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|->=left-[view]->=right-|", options: [], metrics: ["left": insets.left, "right": insets.right], views: ["view": view]))
        addConstraint(NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
    }

    func addSubviewVerticallyCentered(_ view: UIView, insets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|->=top-[view]->=bottom-|", options: [], metrics: ["top": insets.top, "bottom": insets.bottom], views: ["view": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[view]-right-|", options: [], metrics: ["left": insets.left, "right": insets.right], views: ["view": view]))
        addConstraint(NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
    }

    func addSubviewWithConstraintsToBottom(_ view: UIView, insets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[view]-right-|", options: [], metrics: ["left": insets.left, "right": insets.right], views: ["view": view]))
        view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom).isActive = true
    }

    func addSubviewWithConstraintsToTop(_ view: UIView, insets: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[view]-right-|", options: [], metrics: ["left": insets.left, "right": insets.right], views: ["view": view]))
        view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: insets.top).isActive = true
    }

    func set(size: CGSize) {
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }

    func set(height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func set(width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    func getSubview<T>(type: T.Type) -> T? {
        for subview in subviews {
            if let subview = subview as? T {
                return subview
            } else {
                return subview.getSubview(type: type)
            }
        }
        return nil
    }

    func removeAllSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }

    static func makeCenteredView(with subview: UIView, insets: UIEdgeInsets = .zero) -> UIView {
        let view = SpacerView.make()
        view.addSubviewWithConstraintsAsCentered(subview, insets: insets)
        return view
    }

    static func makeView(with subview: UIView, insets: UIEdgeInsets = .zero) -> UIView {
        let view = SpacerView.make()
        view.addSubviewWithConstraints(subview, insets: insets)
        return view
    }

    static func makeViewHorizontallyCentered(with subview: UIView, insets: UIEdgeInsets = .zero) -> UIView {
        let view = SpacerView.make()
        view.addSubviewHorizontallyCentered(subview, insets: insets)
        return view
    }

    static func makeViewVerticallyCentered(with subview: UIView, insets: UIEdgeInsets = .zero) -> UIView {
        let view = SpacerView.make()
        view.addSubviewVerticallyCentered(subview, insets: insets)
        return view
    }

    func zip(insets: UIEdgeInsets = .zero) -> UIView {
        let view = SpacerView.make()
        view.addSubviewHorizontallyCentered(self, insets: insets)
        return view
    }
}

extension UIEdgeInsets {

    public static func make(with offset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: offset, bottom: offset, left: offset, right: offset)
    }

    public static func make(withHorizontalOffset offset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, bottom: 0, left: offset, right: offset)
    }

    public static func make(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, bottom: bottom, left: left, right: right)
    }
}
