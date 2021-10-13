//
//  BaseViewController.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 05/08/2021.
//

import UIKit

class BaseViewController: UIViewController {

    private(set) var isActive = false
    private(set) var gradientView = GradientView()

    var rightButtonCallback: (() -> Void)?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        gradientView = GradientView()
//        gradientView.startColor = C.backgroundGradientStart()
//        gradientView.endColor = C.backgroundGradientEnd()
//        view.addSubviewWithConstraints(gradientView)
//        view.sendSubviewToBack(gradientView)
        view.backgroundColor = C.background()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isActive = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isActive = false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIDevice.current.supportedInterfaceOrientations
    }

    override var shouldAutorotate: Bool {
        return true
    }

    var safeAreaBottomSize: CGFloat {
        return view.safeAreaInsets.bottom
    }

    func setupChildViewController(child: UIViewController) {
        child.willMove(toParent: self)
        addChild(child)
        child.didMove(toParent: self)
    }

    func addChildViewControllerWithSubview(child: UIViewController, into view: UIView) {
        child.willMove(toParent: self)
        addChild(child)
        view.addSubviewWithConstraints(child.view)
        child.didMove(toParent: self)
    }
}
