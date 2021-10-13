//
//  NavigationControllerBox.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 05/08/2021.
//

import UIKit

final class NavigationControllerBox {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func unbox() -> UINavigationController? {
        return navigationController
    }
}
