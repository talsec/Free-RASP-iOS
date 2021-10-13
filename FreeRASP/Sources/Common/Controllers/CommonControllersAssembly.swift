//
//  CommonControllersAssembly.swift
//  CybeTribe
//
//  Created by TalsecApp on 09/09/2021.
//  Copyright © 2021 Talsec. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration

class CommonControllersAssembly: Assembly {

    private let appDelegateInterface: AppDelegateInterface?

    init(appDelegateInterface: AppDelegateInterface?) {
        self.appDelegateInterface = appDelegateInterface
    }

    func assemble(container: Container) {
        container.autoregister(AppWillEnterForegroundController.self, initializer: AppWillEnterForegroundControllerImpl.init).inObjectScope(.container)
    }
}
