//
//  UIViewController+Extensions.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 05/08/2021.
//

import UIKit

extension UIViewController {

    var isDarkModeEnabled: Bool {
        if #available(iOS 12.0, *) {
            return traitCollection.userInterfaceStyle == .dark
        } else {
            return false
        }
    }

    func dismissModals(animated: Bool, dismissSelf: Bool = false, completion: @escaping () -> Void) {
        if let presented = self.presentedViewController, presented != self {
            presented.dismiss(animated: animated, completion: { [weak self] in
                self?.dismissModals(animated: animated, dismissSelf: dismissSelf, completion: completion)
            })
        } else if dismissSelf, self.presentingViewController != nil {
            self.dismiss(animated: animated, completion: completion)
        } else {
            completion()
        }
    }

    func dismissAllModalsAtOnce(completion: (() -> Void)?) {
        if let presentingViewController = presentingViewController {
            presentingViewController.dismissAllModalsAtOnce(completion: completion)
        } else {
            dismiss(animated: true, completion: completion)
        }
    }

    func clearControllers(animated: Bool = true, completion: (() -> Void)? = nil) {
        dismissModals(animated: animated) { [weak self] in
            self?.navigationController?.popToRootViewController(animated: animated)
            completion?()
        }
    }

    func topViewController() -> UIViewController {
        if let lastInNavigation = self.navigationController?.viewControllers.last, lastInNavigation != self {
            return lastInNavigation.topViewController()
        } else {
            return topModalViewController()
        }
    }

    func topModalViewController() -> UIViewController {
        if let presented = self.presentedViewController {
            return presented.topModalViewController()
        } else {
            return self
        }
    }

    func addSubviewToSafeContent(_ subview: UIView, edges: UIEdgeInsets = UIEdgeInsets()) {
        let guide = view.safeAreaLayoutGuide

        subview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subview)
        NSLayoutConstraint.activate([
            guide.topAnchor.constraint(equalTo: subview.topAnchor, constant: -edges.top),
            guide.bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: edges.bottom),
            guide.leadingAnchor.constraint(equalTo: subview.leadingAnchor, constant: -edges.left),
            guide.trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: edges.right),
        ])
    }

    func addSubviewToContent(_ subview: UIView, edges: UIEdgeInsets = UIEdgeInsets()) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subview)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: subview.topAnchor, constant: -edges.top),
            view.bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: edges.bottom),
            view.leadingAnchor.constraint(equalTo: subview.leadingAnchor, constant: -edges.left),
            view.trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: edges.right),
        ])
    }

    func addSubviewToTopSafeContent(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subview)

        view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: subview.topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: subview.bottomAnchor, constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: subview.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: subview.trailingAnchor, constant: 0).isActive = true
    }
}

extension UIActivityViewController {

    func setPopoverControllerIfAvailable(sender: UIView) {
        if let popoverController = self.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
    }
}
extension UIAlertController {

    func setPopoverControllerIfAvailable(sender: UIView) {
        if let popoverController = self.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY, width: 0, height: 0)
        }
    }
}
