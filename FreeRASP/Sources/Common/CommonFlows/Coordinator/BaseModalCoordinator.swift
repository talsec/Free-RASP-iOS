//
//  BaseModalCoordinator.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 05/08/2021.
//

import UIKit

protocol BaseModalCoordinable {
    func getVisibleViewController() -> UIViewController?
    func present(viewController: UIViewController, animated: Bool)
    func presentOverFullscreen(viewController: UIViewController, animated: Bool)
    func present(viewController: UIViewController, modalPresentationStyle: UIModalPresentationStyle, animated: Bool)
    func dismiss()
    func dismiss(completion: @escaping () -> Void)
    func dismiss(animated: Bool)
    func dismiss(animated: Bool, completion: @escaping () -> Void)
    func dismissModals(animated: Bool)
    func dismissModals(animated: Bool, dismissSelf: Bool)
    func dismissModals(animated: Bool, dismissSelf: Bool, completion: @escaping () -> Void)
    /// Dismissing all presented modal ViewControllers in a single animation - use ONLY when navigation information is not being lost by multiple dismissals at once.
    /// - Parameter completion: Completion block that runs when modals are dismissed.
    func dismissAllModalsAtOnce(completion: (() -> Void)?)
}

class BaseModalCoordinator: BaseModalCoordinable {
    weak var rootViewController: UIViewController?
    let instanceProvider: InstanceProvider

    init(instanceProvider: InstanceProvider) {
        self.instanceProvider = instanceProvider
    }

    func present(viewController: UIViewController, animated: Bool) {
        present(viewController: viewController, modalPresentationStyle: .fullScreen, animated: animated)
    }

    func present(viewController: UIViewController, modalPresentationStyle: UIModalPresentationStyle, animated: Bool) {
        if let presentableViewController = rootViewController?.topModalViewController() {
            viewController.modalPresentationStyle = modalPresentationStyle
            presentableViewController.present(viewController, animated: animated, completion: nil)
        }
    }

    func presentOverFullscreen(viewController: UIViewController, animated: Bool) {
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        rootViewController?.present(viewController, animated: true, completion: nil)
        //present(viewController: viewController, modalPresentationStyle: .overFullScreen, animated: animated)
    }

    func dismiss() {
        dismiss(animated: true, completion: {})
    }

    func dismiss(completion: @escaping () -> Void) {
        dismiss(animated: true, completion: completion)
    }

    func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: {})
    }

    func dismiss(animated: Bool, completion: @escaping () -> Void) {
        rootViewController?.dismiss(animated: animated, completion: completion)
    }

    public func dismissModals(animated: Bool) {
        dismissModals(animated: animated, dismissSelf: false, completion: {})
    }

    public func dismissModals(animated: Bool, dismissSelf: Bool) {
        dismissModals(animated: animated, dismissSelf: dismissSelf, completion: {})
    }

    public func dismissModals(animated: Bool, dismissSelf: Bool, completion: @escaping () -> Void) {
        rootViewController?.dismissModals(animated: animated, dismissSelf: dismissSelf, completion: completion)
    }

    public func dismissAllModalsAtOnce(completion: (() -> Void)?) {
        rootViewController?.dismissAllModalsAtOnce(completion: completion)
    }

    func getVisibleViewController() -> UIViewController? {
        return rootViewController
    }
}
