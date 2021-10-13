//
//  ProtectionStatusViewModel.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 06/08/2021.
//

import SwiftUI

class ProtectionStatusViewModel: ObservableObject {
    weak var view: ProtectionStatusView?

    @Published private(set) var loading: Bool = false
    @Published private(set) var meterState: ProtectionMeterState = .none
    @Published private(set) var meterArrowDegrees = -180.0
    
    let coordinator: ProtectionStatusCoordinator
    let securityScoreService: SecurityScoreService

    let meterGradient = Gradient(colors: [
        Color(C.angularGradientHigh.name),
        Color(C.angularGradientHighMedium.name),
        Color(C.angularGradientMedium.name),
        Color(C.angularGradientMediumLow.name),
        Color(C.angularGradientLow.name)
    ])

    let backgroundGradient = Gradient(colors: [
        Color(C.meterBGGradientStart.name),
        Color(C.meterBGGradientEnd.name)
    ])
    
    init(coordinator: ProtectionStatusCoordinator, securityScoreService: SecurityScoreService) {
        self.coordinator = coordinator
        self.securityScoreService = securityScoreService
    }


    func viewDidLoad() {
        view?.set(title: L.tabBarProtectionStatusTitle())
        view?.configure(cells: [])
    }

    private func fillData() {
        var cells: [UIView] = []
        ProtectionCategory.allCases.forEach { category in
            let header = ProtectionStatusHeaderView.loadFromNib()
            header.configure(for: category)
            cells.append(header)
            category.protectionTypes.forEach {
                let cell = ProtectionStatusTypeCellView.loadFromNib()
                cell.configure($0, isOk: isOk(for: $0))
                cells.append(cell)
            }
        }
        view?.configure(cells: cells)
    }

    private func isOk(for type: ProtectionType) -> Bool {
        !SecurityService.shared.securityRisks.contains(type)
    }

    func tapOnStart() {
        meterState = .none
        loading = true
        withAnimation {
            meterArrowDegrees = -180.0
        }
        view?.configure(cells: [])

        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.loading = false
            let score = self.computeScore()
            self.meterState = .score(score.0, score.1)
            withAnimation {
                self.meterArrowDegrees = self.computeDegrees(riskPercentage: score.1)
            }
            self.fillData()
        }
    }

    private func computeScore() -> (ProtectionMeterRiskType, Int) {
        let score = securityScoreService.getScore()

        switch score {
        case 0...60: return (.high, score)
        case 61...99: return (.medium, score)
        case 100: return (.low, score)
        default: return (.low, 100)
        }
    }

    private func computeDegrees(riskPercentage: Int) -> Double {
        let result = Double((140.0 * 2.0) * (Double(riskPercentage) / 100.0) - 140.0)
        return result
    }
}
