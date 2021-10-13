//
//  AppModule.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 04/08/2021.
//

import UIKit
import Swinject

class AppModule {
    let instanceProvider = InstanceProvider()
    private weak var appDelegate: AppDelegateInterface?

    static let shared = AppModule()

    init() {
        instanceProvider.addAssembliesContent(makeAssemblies())
    }

    func initialize(with appDelegate: AppDelegateInterface) {
        self.appDelegate = appDelegate
        instanceProvider.addAssembliesContent(makeAssemblies())
    }

    func start() -> UIViewController {
        MainModule(parentInstanceProvider: instanceProvider).start()
    }

    func appWillEnterForeground() {
        do {
            try instanceProvider.getInstance(AppWillEnterForegroundController.self).willEnterForeground()
        } catch {}
    }

    private func makeAssemblies() -> [Assembly] {
        return [
            CommonControllersAssembly(appDelegateInterface: appDelegate),
            CommonServicesAssembly(),
            LogAssembly(settings: .init(level: .verbose, filters: .exclude([])))
        ]
    }
}
