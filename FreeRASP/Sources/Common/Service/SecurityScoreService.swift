//
//  SecurityScoreService.swift
//  CybeTribe
//
//  Created by TalsecApp on 22/09/2021.
//  Copyright © 2021 Talsec. All rights reserved.
//

import Foundation

protocol SecurityScoreService {
    func getScore() -> Int
}

class SecurityScoreServiceImpl: SecurityScoreService {

    func getScore() -> Int {
        let score = SecurityService.shared.securityRisks
            .map { $0.scoreDownValue }
            .reduce(100, -)

        return max(score, 0)
    }
}
