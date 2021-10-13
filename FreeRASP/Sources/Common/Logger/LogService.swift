//
//  LogService.swift
//  Bittron
//
//  Created by Jakub Mejtský on 20/02/2020.
//  Copyright © 2020 AHEAD iTec, s.r.o. All rights reserved.
//

import Foundation

protocol LogService {
    func verbose(_ message: String, tag: Info)
    func debug(_ message: String, tag: Info)
    func info(_ message: String, tag: Info)
    func warning(_ message: String, tag: Info)
    func error(_ message: String, tag: Info)
    func error(_ error: Error, tag: Info)
}

class LogServiceImpl: LogService {
    
    private let level: LogLevel
    private let filters: LogFiltersSetting
    private let filter: Info
    var externalLogServices: [ExternalLogService] = []

    init(settings: LogSettings) {
        self.level = settings.level
        self.filters = settings.filters
        self.filter = settings.filter
    }

    func verbose(_ message: String, tag: Info) {
        log(tag: tag, level: .verbose, message: message)
    }

    func debug(_ message: String, tag: Info) {
        log(tag: tag, level: .debug, message: message)
    }

    func info(_ message: String, tag: Info) {
        log(tag: tag, level: .info, message: message)
    }

    func warning(_ message: String, tag: Info) {
        log(tag: tag, level: .warning, message: message)
    }

    func error(_ message: String, tag: Info) {
        log(tag: tag, level: .error, message: message)
    }

    func error(_ error: Error, tag: Info) {
        log(tag: tag, level: .error, message: "\(error)")
        externalLogServices.forEach({ $0.record(error: error) })
    }

    private func log(tag: Info, level: LogLevel, message: String) {
        if self.level <= level && canLog(tag: tag) {
            let message = "\(level.symbol) \(message) \nTimestamp: \(Date()) Tag: \(tag)\n"
            externalLogServices.forEach { $0.log(message: message) }
            #if DEBUG
            print(message)
            #endif
        }
    }

    private func canLog(tag: Info) -> Bool {
        switch filters {
        case .exclude:
            return filter != tag
        case .include:
            return filter == tag
        }
    }
}
