//
//  CommonServicesAssembly.swift
//  CybeTribe
//
//  Created by TalsecApp on 09/09/2021.
//  Copyright © 2021 Talsec. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class CommonServicesAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(SecurityScoreService.self, initializer: SecurityScoreServiceImpl.init)
    }
}
