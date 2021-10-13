//
//  BaseCoordinator.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 05/08/2021.
//

import UIKit

protocol BaseCoordinable: BaseModalCoordinable {
    func popViewController()
    func popToRoot()
    func popToRoot(animated: Bool)
    func pop(toViewController: UIViewController.Type)
    func push(viewController: UIViewController, animated: Bool)
    func present(viewController: UIViewController, animated: Bool)
    func presentOverFullscreen(viewController: UIViewController, animated: Bool)
    func dismiss()
    func dismiss(completion: @escaping () -> Void)
}

class BaseCoordinator: BaseModalCoordinator, BaseCoordinable {
    weak var navigationController: UINavigationController?

    required init(instanceProvider: InstanceProvider, navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init(instanceProvider: instanceProvider)
        rootViewController = navigationController
    }

    func set(rootViewController: UIViewController) {
        navigationController?.viewControllers = [rootViewController]
    }

    override func getVisibleViewController() -> UIViewController? {
        return navigationController?.visibleViewController
    }

    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    func pop(toViewController type: UIViewController.Type) {
        guard let viewController = navigationController?.viewControllers.first(where: { $0.isMember(of: type) }) else {
            popToRoot()
            return
        }

        navigationController?.popToViewController(viewController, animated: true)
    }

    func popToRoot() {
        popToRoot(animated: true)
    }

    func popToRoot(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }

    func push(viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
}
