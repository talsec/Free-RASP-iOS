//
//  Info.swift
//  Bittron
//
//  Created by Jakub Mejtský on 20/02/2020.
//  Copyright © 2020 AHEAD iTec, s.r.o. All rights reserved.
//

import Foundation

struct Info: Equatable, CustomStringConvertible {

    let descriptions: [String]

    init(_ description: String) {
        self.descriptions = [description]
    }

    fileprivate init(_ descriptions: [String]) {
        self.descriptions = descriptions
    }

    init(_ tags: [Info]) {
        self.descriptions = Array(tags.map({ $0.descriptions }).joined())
    }

    var description: String {
        return descriptions.joined(separator: ",")
    }
}

infix operator |

func | (lhs: Info, rhs: Info) -> Info {
    return Info(lhs.descriptions + rhs.descriptions)
}

func == (lhs: Info, rhs: Info) -> Bool {
    if lhs.descriptions.count == 1 && rhs.descriptions.count == 1 {
        return lhs.descriptions == rhs.descriptions
    } else if lhs.descriptions.count == 1 {
        return rhs.descriptions.contains(lhs.descriptions[0])
    } else if rhs.descriptions.count == 1 {
        return lhs.descriptions.contains(rhs.descriptions[0])
    } else {
        return lhs.descriptions.contains { (inner) -> Bool in
            rhs.descriptions.contains(inner)
        }
    }
}
