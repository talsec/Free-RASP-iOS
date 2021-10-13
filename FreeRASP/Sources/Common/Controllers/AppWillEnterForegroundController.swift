//
//  ApplicationWillEnterForegroundController.swift
//  CybeTribe
//
//  Created by TalsecApp on 10/09/2021.
//  Copyright © 2021 Talsec. All rights reserved.
//

import Foundation

protocol AppWillEnterForegroundController: BasePropertyController {
    func willEnterForeground()
}

class AppWillEnterForegroundControllerImpl: BasePropertyControllerImpl, AppWillEnterForegroundController {

    func willEnterForeground() {
        propertyChanged()
    }
}
