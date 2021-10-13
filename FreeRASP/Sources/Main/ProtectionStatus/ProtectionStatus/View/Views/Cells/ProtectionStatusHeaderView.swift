//
//  ProtectionStatusHeaderView.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 17/08/2021.
//

import UIKit

class ProtectionStatusHeaderView: UIView, Loadable {
    @IBOutlet weak var textLabel: UILabel!
    
    func configure(for category: ProtectionCategory) {
        textLabel.text = category.title
    }
}
