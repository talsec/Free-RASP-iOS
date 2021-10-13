//
//  AppDelegateInterface.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 04/08/2021.
//

import UIKit

protocol AppDelegateInterface: AnyObject {
    func set(rootViewController: UIViewController)
    func sendFcmToken()
    var mainWindow: UIWindow? { get }
}
