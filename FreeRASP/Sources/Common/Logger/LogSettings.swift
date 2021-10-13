//
//  LogSettings.swift
//  Bittron
//
//  Created by Jakub Mejtský on 20/02/2020.
//  Copyright © 2020 AHEAD iTec, s.r.o. All rights reserved.
//

import Foundation

struct LogSettings {

    let level: LogLevel
    let filters: LogFiltersSetting
    let filter: Info

    static let `default` = LogSettings(level: .info, filters: .exclude([]))

    init(level: LogLevel, filters: LogFiltersSetting) {
        self.level = level
        self.filters = filters
        switch filters {
        case let .exclude(excluded):
            self.filter = Info(excluded)
        case let .include(included):
            self.filter = Info(included)
        }
    }
}
