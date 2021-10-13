//
//  LogAssembly.swift
//  CybeTribe
//
//  Created by Talsec on 09/09/2021.
//  Copyright © 2020 AHEAD iTec, s.r.o. All rights reserved.
//

import Foundation
import Swinject

class LogAssembly: Assembly {

    private let settings: LogSettings

    init(settings: LogSettings) {
        self.settings = settings
    }

    func assemble(container: Container) {
        let settings = self.settings

        container.register(LogService.self) { r in
            r.resolve(LogServiceImpl.self)!
        }

        container.register(LogServiceImpl.self) { _ in
            return LogServiceImpl(settings: settings)
        }.initCompleted { (r, logService) in
            if let externalLogServices = r.resolve([ExternalLogService].self) {
                logService.externalLogServices = externalLogServices
            }
        }.inObjectScope(.container)

        container.register([ExternalLogService].self) { _ in
            return []
        }
    }
}
