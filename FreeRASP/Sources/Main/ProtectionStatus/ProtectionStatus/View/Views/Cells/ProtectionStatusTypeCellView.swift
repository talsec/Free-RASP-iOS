//
//  ProtectionStatusTypeCellView.swift
//  FreeRASPDemoApp
//
//  Created by Talsec.app on 17/08/2021.
//

import UIKit

class ProtectionStatusTypeCellView: UIView, Loadable {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var riskStatusImage: UIImageView!
    @IBOutlet weak var riskTitleLabel: UILabel!
    @IBOutlet weak var riskStatusLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var riskInfoContainerView: UIView!
    @IBOutlet weak var riskInfoLabel: UILabel!
    @IBOutlet weak var overlayButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        riskInfoContainerView.isHidden = true
        expandButton.setImage(Image.arrow_down(), for: .normal)
        overlayButton.setTitle(nil, for: .normal)
    }
    
    func configure(_ riskType: ProtectionType, isOk: Bool) {
        riskStatusImage.image = isOk ? Image.riskOk() : Image.riskNok()
        riskTitleLabel.text = riskType.title
        riskStatusLabel.text = isOk ? riskType.ok : riskType.nok
        riskInfoLabel.text = riskType.description
    }
    
    @IBAction func expandTapAction(_ sender: Any) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
            self.riskInfoContainerView.isHidden = !self.riskInfoContainerView.isHidden
            let newImage = self.riskInfoContainerView.isHidden ? Image.arrow_down() : Image.arrow_up()
            self.expandButton.setImage(newImage, for: .normal)
            self.stackView.layoutIfNeeded()
        }
    }
}
