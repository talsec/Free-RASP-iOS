//
//  InstanceProvider.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 04/08/2021.
//

import Foundation
import Swinject

enum ModuleInstanceProviderError: Error {
    case unableToResolveService
}

final class InstanceProviderBox {
    private weak var object: InstanceProvider?

    init(object: InstanceProvider) {
        self.object = object
    }

    func unbox() -> InstanceProvider? {
        return object
    }
}

final class InstanceProvider {
    private let container: Container

    init(parentInstanceProvider: InstanceProvider? = nil) {
        container = Container(parent: parentInstanceProvider?.container)
    }

    func addAssembliesContent(_ submodules: [Assembly]) {
        container.removeAll()
        submodules.forEach(register)
    }

    func register(submodules: [Assembly]) {
        submodules.forEach(register)
    }

    private func register(submodule: Assembly) {
        submodule.assemble(container: container)
    }

    func getInstance<T>(_ type: T.Type) throws -> T {
        guard let resolvedService = container.resolve(type) else {
            throw ModuleInstanceProviderError.unableToResolveService
        }

        return resolvedService
    }

    func getInstance<T>(_ type: T.Type, name: String) throws -> T {
        guard let resolvedService = container.resolve(type, name: name) else {
            throw ModuleInstanceProviderError.unableToResolveService
        }

        return resolvedService
    }

    func getInstance<T, ArgType>(_ type: T.Type, argument arg: ArgType) throws -> T {
        guard let resolvedService = container.resolve(type, argument: arg) else {
            throw ModuleInstanceProviderError.unableToResolveService
        }

        return resolvedService
    }

    func getInstance<T, ArgType>(_ type: T.Type, name: String, argument arg: ArgType) throws -> T {
        guard let resolvedService = container.resolve(type, name: name, argument: arg) else {
            throw ModuleInstanceProviderError.unableToResolveService
        }

        return resolvedService
    }

    func getInstance<T, Arg1, Arg2>(_ type: T.Type, arguments arg1: Arg1, _ arg2: Arg2) throws -> T {
        guard let resolvedService = container.resolve(type, arguments: arg1, arg2) else {
            throw ModuleInstanceProviderError.unableToResolveService
        }

        return resolvedService
    }

    func getInstance<T, Arg1, Arg2>(_ type: T.Type, name: String, arguments arg1: Arg1, _ arg2: Arg2) throws -> T {
        guard let resolvedService = container.resolve(type, name: name, arguments: arg1, arg2) else {
            throw ModuleInstanceProviderError.unableToResolveService
        }

        return resolvedService
    }

    func getInstance<T, Arg1, Arg2, Arg3>(_ type: T.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) throws -> T {
        guard let resolvedService = container.resolve(type, arguments: arg1, arg2, arg3) else {
            throw ModuleInstanceProviderError.unableToResolveService
        }

        return resolvedService
    }
}
