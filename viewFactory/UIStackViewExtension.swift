//
//  UIStackViewExtension.swift
//  viewFactory
//
//  Created by Pericles Narbal Da Costa De Oliveira (ACT CONSULTORIA EM TECNOLOGIA LTDA – DITEC – CE) on 28/09/22.
//

import UIKit

extension UIStackView {
    func addSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        let separatorView = UIView(frame: .zero)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        switch axis {
        case .horizontal:
            separatorView.widthAnchor.constraint(equalToConstant: spacing).isActive = true
        case .vertical:
            separatorView.heightAnchor.constraint(equalToConstant: spacing).isActive = true
        @unknown default:
            return
        }
        if let index = arrangedSubviews.firstIndex(of: arrangedSubview) {
            insertArrangedSubview(separatorView, at: index + 1)
        }
    }
}
