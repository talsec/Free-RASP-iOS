//
//  BasePropertyTypeController.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 20/08/2021.
//

import Foundation

private struct WeakBlockSubscriber<T> {
    weak var subscriber: AnyObject?
    let block: ((T) -> Void)?
}

public protocol BasePropertyTypeController {
    associatedtype T
    func registerForUpdate(subscriber: AnyObject, callback: @escaping (T) -> Void)
    func registerForUpdate(subscriber: AnyObject, callImmediately: Bool, callback: @escaping (T) -> Void)
    func unregister(subscriber: AnyObject)
}

open class BasePropertyTypeControllerImpl<Value>: BasePropertyTypeController {
    public typealias T = Value

    private var subscribers = [WeakBlockSubscriber<Value>]()
    private var lastValue: Value?

    public init() {}

    public func registerForUpdate(subscriber: AnyObject, callback: @escaping (Value) -> Void) {
        // Clean non - existing weak references
        subscribers = subscribers.filter({ $0.subscriber != nil })

        unregister(subscriber: subscriber)
        let weakSubscriber = WeakBlockSubscriber<T>(subscriber: subscriber, block: callback)
        subscribers.append(weakSubscriber)
    }

    public func registerForUpdate(subscriber: AnyObject, callImmediately: Bool, callback: @escaping (Value) -> Void) {
        registerForUpdate(subscriber: subscriber, callback: callback)
        if callImmediately, let lastValue = lastValue {
            callback(lastValue)
        }
    }

    public func unregister(subscriber: AnyObject) {
        if let index = subscribers.firstIndex(where: { $0.subscriber === subscriber }) {
            subscribers.remove(at: index)
        }
    }

    public func propertyChanged(value: Value, saveLastValue: Bool = true) {
        if saveLastValue {
            lastValue = value
        }
        subscribers = subscribers.filter({ $0.subscriber != nil })

        for subscriber in subscribers {
            subscriber.block?(value)
        }
    }
}
