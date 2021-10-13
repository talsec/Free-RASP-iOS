//
//  ExternalLogService.swift
//  Bittron
//
//  Created by Jakub Mejtský on 20/02/2020.
//  Copyright © 2020 AHEAD iTec, s.r.o. All rights reserved.
//

import Foundation

protocol ExternalLogService {
    func log(message: String)
    func record(error: Error)
    func record(nsError: NSError)
}
