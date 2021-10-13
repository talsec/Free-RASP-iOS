//
//  MainModule.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 04/08/2021.
//

import UIKit
import Swinject

class MainModule {
    private let instanceProvider: InstanceProvider

    init(parentInstanceProvider: InstanceProvider) {
        instanceProvider = InstanceProvider(parentInstanceProvider: parentInstanceProvider)
    }

    func start() -> UIViewController {
        instanceProvider.addAssembliesContent(makeAssemblies())
        do {
            return try ProtectionStatusModule(parentInstanceProvider: instanceProvider).start()
        } catch {
            return UITabBarController()
        }
    }

    private func makeAssemblies() -> [Assembly] {
        return []
    }
}
