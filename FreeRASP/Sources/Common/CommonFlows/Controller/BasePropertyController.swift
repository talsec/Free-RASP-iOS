//
//  BasePropertyController.swift
//  CybeTribe
//
//  Created by TalsecApp on 09/09/2021.
//  Copyright © 2021 Talsec. All rights reserved.
//

import Foundation

private struct WeakBlockSubscriber {
    weak var subscriber: AnyObject?
    let block: (() -> Void)?
}

protocol BasePropertyController {
    func registerForUpdate(subscriber: AnyObject, callback: @escaping () -> Void)
    func registerForUpdate(subscriber: AnyObject, callCallbackDirectly: Bool, callback: @escaping () -> Void)
    func unregister(subscriber: AnyObject)
}

class BasePropertyControllerImpl: NSObject, BasePropertyController {
    private var subscribers = [WeakBlockSubscriber]()

    override init() {
        super.init()
    }

    func registerForUpdate(subscriber: AnyObject, callback: @escaping () -> Void) {
        registerForUpdate(subscriber: subscriber, callCallbackDirectly: true, callback: callback)
    }

    func registerForUpdate(subscriber: AnyObject, callCallbackDirectly: Bool, callback: @escaping () -> Void) {
        // Clean non-existing weak references
        subscribers = subscribers.filter({ $0.subscriber != nil })

        unregister(subscriber: subscriber)
        let weakSubscriber = WeakBlockSubscriber(subscriber: subscriber, block: callback)
        subscribers.append(weakSubscriber)
        if callCallbackDirectly {
            callback()
        }
    }

    func unregister(subscriber: AnyObject) {
        if let index = subscribers.firstIndex(where: { $0.subscriber === subscriber }) {
            subscribers.remove(at: index)
        }
    }

    func clearSubscribers() {
        subscribers = subscribers.filter({ $0.subscriber != nil })
    }

    func propertyChanged() {
        clearSubscribers()
        for subscriber in subscribers {
            subscriber.block?()
        }
    }
}
