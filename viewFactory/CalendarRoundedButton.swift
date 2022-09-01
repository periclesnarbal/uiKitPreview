//
//  CalendarRoundedButton.swift
//  viewFactory
//
//  Created by Pericles Narbal Da Costa De Oliveira (ACT CONSULTORIA EM TECNOLOGIA LTDA – DITEC – CE) on 29/08/22.
//

import UIKit

class CalendarRoundedButton: UIButton {
    
    // MARK: Public Properties
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selected()
            } else {
                unselcted()
            }
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupButton()
    }
    
    // MARK: Init Methods
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    // MARK: Private Methods
    
    private func setupButton() {
        unselcted()
        tintColor = .clear
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        layer.borderColor = CalendarColorHelper.gray.cgColor
    }
    
    private func selected() {
        backgroundColor = CalendarColorHelper.orange
        setTitleColor(.white, for: .normal)
        layer.borderWidth = 0
    }
    
    private func unselcted() {
        backgroundColor = .white
        setTitleColor(CalendarColorHelper.blackText, for: .normal)
        layer.borderWidth = 1
    }
}
