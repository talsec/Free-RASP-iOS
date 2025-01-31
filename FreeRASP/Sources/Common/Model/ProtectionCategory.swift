//
//  ProtectionCategory.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 17/08/2021.
//

import Foundation

enum ProtectionCategory: CaseIterable {
    case deviceSecurity
    case inDepthAnalysis
    
    var title: String {
        switch self {
        case .deviceSecurity:   return L.protectionStatusCategoryDeviceSecurity()
        case .inDepthAnalysis:  return L.protectionStatusCategoryInDepthAnalysis()
        }
    }
    
    var protectionTypes: [ProtectionType] {
        switch self {
        case .deviceSecurity:
            return [
                .passcode,
                .passcodeChange,
                .secureEnclave,
                .jailbreak,
                .systemVPN
            ]
        case .inDepthAnalysis:
            return [
                .signature,
                .debugger,
                .simulator,
                .runtimeManipulation,
                .unofficialStore,
                .screenshot,
                .screenRecording
            ]
        }
    }
}
