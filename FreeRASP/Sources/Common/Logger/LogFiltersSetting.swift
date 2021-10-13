//
//  LogFiltersSetting.swift
//  Bittron
//
//  Created by Jakub Mejtský on 20/02/2020.
//  Copyright © 2020 AHEAD iTec, s.r.o. All rights reserved.
//

import Foundation

enum LogFiltersSetting {
    case exclude([Info])
    case include([Info])
}
