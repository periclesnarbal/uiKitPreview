//
//  UILabelExtension.swift
//  viewFactory
//
//  Created by Pericles Narbal Da Costa De Oliveira (ACT CONSULTORIA EM TECNOLOGIA LTDA – DITEC – CE) on 28/09/22.
//

import UIKit

extension UILabel {
    func textWithBold(boldTexts: [String], boldFont: UIFont, boldColor: UIColor) {
        let fullText = self.text ?? ""
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font ?? UIFont(),
            .foregroundColor: textColor ?? UIColor()
        ]
        
        let attributedText = NSMutableAttributedString(string: fullText, attributes: attributes)
        
        let attributedBold: [NSAttributedString.Key: Any] = [
            .font: boldFont,
            .foregroundColor: boldColor
        ]
        
        for text in boldTexts {
            let rangeBold = (fullText as NSString).range(of: text)
            attributedText.addAttributes(attributedBold, range: rangeBold)
        }

        self.attributedText = attributedText
    }
}
