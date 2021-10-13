//
//  ProtectionStatusAssembly.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 06/08/2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class ProtectionStatusAssembly: Assembly {

    func assemble(container: Container) {

        container.register(ProtectionStatusViewController.self) { r in
            let viewModel = r.resolve(ProtectionStatusViewModel.self)!
            let viewController = ProtectionStatusViewController(viewModel: viewModel)
            viewModel.view = viewController
            return viewController
        }

        container.autoregister(ProtectionStatusViewModel.self, initializer: ProtectionStatusViewModel.init)

        container.register(ProtectionStatusCoordinable.self) { r in
            r.resolve(ProtectionStatusCoordinator.self)!
        }
    }
}
