//
//  ProtectionStatusViewController.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 06/08/2021.
//

import SwiftUI
import UIKit
import Combine

protocol ProtectionStatusView: NavigationView {
    func configure(cells: [UIView])
}

final class ProtectionStatusViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var meterContainerView: UIView!
    @IBOutlet weak var resultTopContainerView: UIView!
    @IBOutlet weak var resultTopContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultTextContainerView: UIView!
    @IBOutlet weak var resultTextContainerBottomSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var resultHowLabel: UILabel!
    @IBOutlet weak var contentStackView: UIStackView!
    
    let viewModel: ProtectionStatusViewModel
    var cancellables = Set<AnyCancellable>()

    init(viewModel: ProtectionStatusViewModel) {
        self.viewModel = viewModel
        super.init(nibName: R.nib.protectionStatusViewController.name, bundle: R.nib.protectionStatusViewController.bundle)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMeterView()
        setupStyles()

        viewModel.viewDidLoad()
        handleMeterResult()
        animateResult(height: 0, bottomSpace: 10, isAnimated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //let numbers = [0,1]
        //print(numbers[4])
    }
    
    private func setupMeterView() {
        let vc = UIHostingController(rootView: ProtectionMeterView(viewModel: viewModel))
        vc.view.backgroundColor = .clear
        meterContainerView.addSubviewWithConstraints(vc.view)

        stackView.sendSubviewToBack(resultTopContainerView)
    }
    
    private func setupStyles() {
        resultTextContainerView.layer.cornerRadius = 12
        resultHowLabel.attributedText = L.protectionStatusMeterRiskHow().makeBolded(normalFont: .systemFont(ofSize: 17), boldFont: .systemFont(ofSize: 17, weight: .bold))
    }

    private func handleMeterResult() {
        viewModel.$meterState.sink { [weak self] state in
            self?.showResult(state)
        }
        .store(in: &cancellables)
    }
    
    private func showResult(_ state: ProtectionMeterState) {
        switch state {
        case .none:
            animateResult(height: 0, bottomSpace: 10, isAnimated: true)
        case .score(let riskType, _):
            resultTextContainerView.backgroundColor = riskType.color
            resultTitleLabel.text = riskType.resultTitle
            resultTitleLabel.textColor = riskType.textColor
            resultTextLabel.attributedText = riskType.resultDescription.makeBolded(normalFont: .systemFont(ofSize: 17), boldFont: .systemFont(ofSize: 17, weight: .bold))
            resultTextLabel.textColor = riskType.textColor
            resultHowLabel.textColor = riskType.textColor
            resultTextContainerView.layoutIfNeeded()
            resultTextContainerBottomSpaceConstraint.constant = 10
            let height = resultTextContainerView.frame.height - 48
            let bottomSpace = -1 * resultTextContainerView.frame.height + 24
            animateResult(height: height, bottomSpace: bottomSpace, isAnimated: true)
        }
    }
    
    private func animateResult(height: CGFloat, bottomSpace: CGFloat, isAnimated: Bool) {
        UIView.animate(withDuration: isAnimated ? 0.15 : 0, delay: 0, options: .curveEaseInOut) {
            self.resultTopContainerHeightConstraint.constant = height
            self.resultTextContainerBottomSpaceConstraint.constant = bottomSpace
            self.resultTextContainerView.superview?.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
    
    private func configureEmptyState() {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = L.protectionStatusEmptyState().makeBolded(normalFont: .systemFont(ofSize: 17), boldFont: .systemFont(ofSize: 17, weight: .bold))
        contentStackView.addArrangedSubview(label)
    }
}

extension ProtectionStatusViewController: ProtectionStatusView {
    func configure(cells: [UIView]) {
        contentStackView.removeAllSubviews()
        guard !cells.isEmpty else {
            configureEmptyState()
            return
        }
        
        cells.forEach { contentStackView.addArrangedSubview($0) }
    }
}
