//
//  BaseCommonAssembly.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 05/08/2021.
//

import UIKit
import Swinject
import SwinjectAutoregistration

class BaseCommonAssembly<T: BaseCoordinator>: Assembly {
    private let instanceProviderBox: InstanceProviderBox
    private let navigationControllerBox: NavigationControllerBox

    init(instanceProvider: InstanceProvider, navigationController: UINavigationController) {
        instanceProviderBox = InstanceProviderBox(object: instanceProvider)
        navigationControllerBox = NavigationControllerBox(navigationController: navigationController)
    }

    func assemble(container: Container) {
        container.register(T.self) { _ in
            let instanceProvider = self.instanceProviderBox.unbox()!
            let navigationController = self.navigationControllerBox.unbox()!
            return T(instanceProvider: instanceProvider, navigationController: navigationController)
        }.inObjectScope(.weak)

        container.register(BaseCoordinable.self) { r in
            r.resolve(T.self)!
        }

        container.register(BaseModalCoordinable.self) { r in
            r.resolve(T.self)!
        }

        container.register(BaseCoordinator.self) { r in
            r.resolve(T.self)!
        }
    }
}
