//
//  ProtectionStatusModule.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 04/08/2021.
//

import UIKit
import Swinject

class ProtectionStatusModule {
    private let navigationControler = NavigationController()
    private let instanceProvider: InstanceProvider

    init(parentInstanceProvider: InstanceProvider) {
        instanceProvider = InstanceProvider(parentInstanceProvider: parentInstanceProvider)
    }

    func start() throws -> NavigationController {
        instanceProvider.addAssembliesContent(makeAssemblies())
        let commonAssembly = ProtectionStatusCommonAssembly(instanceProvider: instanceProvider, navigationController: navigationControler)
        instanceProvider.register(submodules: [commonAssembly])
        let viewController = try instanceProvider.getInstance(ProtectionStatusViewController.self)
        navigationControler.viewControllers = [viewController]
        return navigationControler
    }

    private func makeAssemblies() -> [Assembly] {
        return [
            ProtectionStatusAssembly()
        ]
    }
}
