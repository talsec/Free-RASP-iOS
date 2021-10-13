//
//  NavigationView.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 05/08/2021.
//

import UIKit

protocol NavigationView: AnyObject {
    func set(title: String)
    func setRightButtonItem(image: UIImage?, target: Any?, selector: Selector?)
}

extension NavigationView where Self: BaseViewController {
    func set(title: String) {
        navigationItem.title = title
    }
    
    func setRightButtonItem(image: UIImage?, target: Any?, selector: Selector?) {
        let item = UIBarButtonItem(image: image, style: .plain, target: target, action: selector)
        navigationItem.rightBarButtonItem = item
    }
}
