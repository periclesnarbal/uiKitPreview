//
//  CalendarUtils.swift
//  viewFactory
//
//  Created by Pericles Narbal Da Costa De Oliveira (ACT CONSULTORIA EM TECNOLOGIA LTDA – DITEC – CE) on 01/09/22.
//

import UIKit

struct CalendarUtils {
    
    static func addPartialCornerRadius(view: UIView, cornerRadius: CGFloat, corners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner], legacyCorners: UIRectCorner = [.topLeft , .bottomLeft]) {
        if #available(iOS 11.0, *) {
            view.layer.cornerRadius = cornerRadius
            view.layer.maskedCorners = corners
            view.clipsToBounds = true
        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = view.frame
            rectShape.position = view.center
            rectShape.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: legacyCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            view.layer.mask = rectShape
        }
    }
}
