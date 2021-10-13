//
//  LogLevel.swift
//  Bittron
//
//  Created by Jakub Mejtský on 20/02/2020.
//  Copyright © 2020 AHEAD iTec, s.r.o. All rights reserved.
//

import Foundation

enum LogLevel: Int, Comparable {
    case verbose = 0
    case debug
    case info
    case warning
    case error

    static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    var symbol: String {
        switch self {
        case .verbose:
            return "💜"
        case .debug:
            return "💙"
        case .info:
            return "ℹ️"
        case .warning:
            return "⚠️"
        case .error:
            return "🛑"
        }
    }
}
