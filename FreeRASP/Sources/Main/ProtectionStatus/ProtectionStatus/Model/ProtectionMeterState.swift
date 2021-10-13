//
//  ProtectionMeterState.swift
//  FreeRASP Demo
//
//  Created by TalsecApp on 22/06/2021.
//

import Foundation

enum ProtectionMeterState {
    case none
    case score(ProtectionMeterRiskType, Int)

    var title: String {
        switch self {
        case .none:
            return L.protectionStatusMeterStart()
        case .score(_, let score):
            return "\(score)%"
        }
    }
}
