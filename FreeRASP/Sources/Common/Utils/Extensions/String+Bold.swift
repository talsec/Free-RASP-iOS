//
//  String+Bold.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 19/08/2021.
//

import UIKit

extension String {
    func makeBolded(normalFont: UIFont, boldFont: UIFont) -> NSMutableAttributedString {
        let arrayOfStrings = self.components(separatedBy: "**")
        let attributedString = NSMutableAttributedString(string: "")
        arrayOfStrings.enumerated().forEach { index, string in
            if index % 2 == 0 {
                attributedString.append(NSAttributedString(string: string, attributes: [
                    .font: normalFont
                ]))
            } else {
                attributedString.append(NSAttributedString(string: string, attributes: [
                    .font: boldFont
                ]))
            }
        }
        return attributedString
    }
}
