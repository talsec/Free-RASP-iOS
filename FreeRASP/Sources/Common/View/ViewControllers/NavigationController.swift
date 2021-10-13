//
//  NavigationController.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 05/08/2021.
//

import UIKit

class NavigationController: UINavigationController {
    override var preferredStatusBarStyle : UIStatusBarStyle {
        if let topVC = viewControllers.last {
            return topVC.preferredStatusBarStyle
        }

        return .default
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIDevice.current.supportedInterfaceOrientations
    }

    override var shouldAutorotate: Bool {
        return true
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        setupNavigationBar()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .clear
        appearance.backgroundEffect = .none
        appearance.titleTextAttributes = [.foregroundColor: C.blueBlack() as Any]
        appearance.largeTitleTextAttributes = [.foregroundColor: C.blueBlack() as Any]
        appearance.shadowImage = UIImage()
        appearance.backgroundImage = UIImage()
        appearance.shadowColor = .clear
        return appearance
    }

    func setupNavigationBar() {
        //let appearance = configureBarAppearance()

        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = C.midTeal()
        navigationBar.isTranslucent = true
        navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white

        navigationItem.largeTitleDisplayMode = .never
//        navigationBar.prefersLargeTitles = true
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
//        navigationBar.isTranslucent = true
//        //navigationBar.standardAppearance = appearance
//        //navigationBar.scrollEdgeAppearance = appearance
//        navigationBar.tintColor = .white

        //navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.darkGray]
    }
}
