//
//  ProtectionMeterRiskType.swift
//  FreeRASP Demo
//
//  Created by TalsecApp on 22/06/2021.
//

import UIKit

enum ProtectionMeterRiskType {
    case low
    case medium
    case high

    var color: UIColor? {
        switch self {
        case .low:      return C.riskColorLow()
        case .medium:   return C.riskColorMedium()
        case .high:     return C.riskColorHigh()
        }
    }
    
    var textColor: UIColor? {
        switch self {
        case .high, .medium:
            return .white
        case .low:
            return .black
        }
    }

    var resultTitle: String {
        switch self {
        case .low:      return L.protectionStatusMeterRiskLowResultTitle()
        case .medium:   return L.protectionStatusMeterRiskMediumResultTitle()
        case .high:     return L.protectionStatusMeterRiskHighResultTitle()
        }
    }

    var resultDescription: String {
        switch self {
        case .low:      return L.protectionStatusMeterRiskLowResultDescription()
        case .medium:   return L.protectionStatusMeterRiskMediumResultDescription()
        case .high:     return L.protectionStatusMeterRiskHighResultDescription()
        }
    }
}
