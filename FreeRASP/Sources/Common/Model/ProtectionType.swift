//
//  ProtectionType.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 06/08/2021.
//

import Foundation

enum ProtectionType {
    case passcode
    case passcodeChange
    case secureEnclave
    case jailbreak
    case signature
    case debugger
    case simulator
    case runtimeManipulation
    case deviceBinding
    case unofficialStore

    var scoreDownValue: Int {
        switch self {
        case .passcode:             return 31
        case .passcodeChange:       return 31
        case .secureEnclave:        return 47
        case .jailbreak:            return 53
        case .signature:            return 53
        case .debugger:             return 53
        case .simulator:            return 47
        case .runtimeManipulation:  return 53
        case .deviceBinding:        return 0
        case .unofficialStore:      return 21
        }
    }

    var title: String {
        switch self {
        case .passcode:             return L.protectionStatusTypePasscodeTitle()
        case .passcodeChange:       return L.protectionStatusTypePasscodeChangeTitle()
        case .secureEnclave:        return L.protectionStatusTypeSecureEnclaveTitle()
        case .jailbreak:            return L.protectionStatusTypeJailbreakTitle()
        case .signature:            return L.protectionStatusTypeSignatureTitle()
        case .debugger:             return L.protectionStatusTypeDebuggerTitle()
        case .simulator:            return L.protectionStatusTypeSimulatorTitle()
        case .runtimeManipulation:  return L.protectionStatusTypeRuntimeManipulationTitle()
        case .deviceBinding:        return L.protectionStatusTypeDeviceBindingTitle()
        case .unofficialStore:      return L.protectionStatusTypeUnofficialStoreTitle()
        }
    }

    var description: String {
        switch self {
        case .passcode:             return L.protectionStatusTypePasscodeDescription()
        case .passcodeChange:       return L.protectionStatusTypePasscodeChangeDescription()
        case .secureEnclave:        return L.protectionStatusTypeSecureEnclaveDescription()
        case .jailbreak:            return L.protectionStatusTypeJailbreakDescription()
        case .signature:            return L.protectionStatusTypeSignatureDescription()
        case .debugger:             return L.protectionStatusTypeDebuggerDescription()
        case .simulator:            return L.protectionStatusTypeSimulatorDescription()
        case .runtimeManipulation:  return L.protectionStatusTypeRuntimeManipulationDescription()
        case .deviceBinding:        return L.protectionStatusTypeDeviceBindingDescription()
        case .unofficialStore:      return L.protectionStatusTypeUnofficialStoreDescription()
        }
    }

    var ok: String {
        switch self {
        case .passcode:             return L.protectionStatusTypePasscodeOk()
        case .passcodeChange:       return L.protectionStatusTypePasscodeChangeOk()
        case .secureEnclave:        return L.protectionStatusTypeSecureEnclaveOk()
        case .jailbreak:            return L.protectionStatusTypeJailbreakOk()
        case .signature:            return L.protectionStatusTypeSignatureOk()
        case .debugger:             return L.protectionStatusTypeDebuggerOk()
        case .simulator:            return L.protectionStatusTypeSimulatorOk()
        case .runtimeManipulation:  return L.protectionStatusTypeRuntimeManipulationOk()
        case .deviceBinding:        return L.protectionStatusTypeDeviceBindingOk()
        case .unofficialStore:      return L.protectionStatusTypeUnofficialStoreOk()
        }
    }

    var nok: String {
        switch self {
        case .passcode:             return L.protectionStatusTypePasscodeNok()
        case .passcodeChange:       return L.protectionStatusTypePasscodeChangeNok()
        case .secureEnclave:        return L.protectionStatusTypeSecureEnclaveNok()
        case .jailbreak:            return L.protectionStatusTypeJailbreakNok()
        case .signature:            return L.protectionStatusTypeSignatureNok()
        case .debugger:             return L.protectionStatusTypeDebuggerNok()
        case .simulator:            return L.protectionStatusTypeSimulatorNok()
        case .runtimeManipulation:  return L.protectionStatusTypeRuntimeManipulationNok()
        case .deviceBinding:        return L.protectionStatusTypeDeviceBindingNok()
        case .unofficialStore:      return L.protectionStatusTypeUnofficialStoreNok()
        }
    }
}
