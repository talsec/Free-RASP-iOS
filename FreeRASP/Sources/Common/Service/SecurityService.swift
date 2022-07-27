//
//  SecurityService.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 06/08/2021.
//

import Foundation
import TalsecRuntime

class SecurityService {
    static let shared = SecurityService()
    var securityRisks = Set<ProtectionType>()

    func appendThreat(_ securityThreat: TalsecRuntime.SecurityThreat) {
        switch securityThreat {
        case .signature:                securityRisks.insert(.signature)
        case .jailbreak:                securityRisks.insert(.jailbreak)
        case .debugger:                 securityRisks.insert(.debugger)
        case .runtimeManipulation:      securityRisks.insert(.runtimeManipulation)
        case .passcode:                 securityRisks.insert(.passcode)
        case .passcodeChange:           securityRisks.insert(.passcodeChange)
        case .simulator:                securityRisks.insert(.simulator)
        case .missingSecureEnclave:     securityRisks.insert(.secureEnclave)
        case .deviceChange:             securityRisks.insert(.deviceBinding)
        case .unofficialStore:          securityRisks.insert(.unofficialStore)
        case .deviceID:                 break
        @unknown default:               break
        }
    }
}

extension SecurityThreatCenter: SecurityThreatHandler {
    public func threatDetected(_ securityThreat: SecurityThreat) {
        print("Found incident: \(securityThreat)")
        SecurityService.shared.appendThreat(securityThreat)
    }
}
