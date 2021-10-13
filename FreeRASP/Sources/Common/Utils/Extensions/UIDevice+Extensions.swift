//
//  UIDevice+Extensions.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 05/08/2021.
//

import UIKit

extension UIDevice {
    private func platform() -> String {
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }

    var isHapticSupported: Bool {
        switch platform() {
        case "iPhone8,4", "iPhone8,2", "iPhone8,1", "iPhone7,2", "iPhone7,1", "iPhone6,2", "iPhone6,1", "iPhone5,3", "iPhone5,4", "iPhone5,1", "iPhone5,2":
            return false
        default:
            return true
        }
    }

    var isIpad: Bool {
        return platform().lowercased().contains("ipad")
    }

    var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIDevice.current.isIpad ? .all : .portrait
    }
}
