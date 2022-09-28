//
//  LeftIconTitleAndDescriptionView.swift
//  viewFactory
//
//  Created by Pericles Narbal Da Costa De Oliveira (ACT CONSULTORIA EM TECNOLOGIA LTDA – DITEC – CE) on 28/09/22.
//

import SwiftUI
import UIKit

protocol SideIconTitleAndDescriptionViewProtocol {
    func addDescription(label: UILabel, spacingAfter spacing: CGFloat)
    func addButton(button: UIButton, spacingAfter spacing: CGFloat)
}

final class SideIconTitleAndDescriptionView: UIView, SideIconTitleAndDescriptionViewProtocol {
    
    // MARK: Propriedades Públicas
    
    let iconImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Propriedades Privadas
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .top
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: Inicializadores
    
    init(frame: CGRect = .zero, icon: UIImage? = nil, iconSize: CGSize = CGSize(width: 24, height: 24), iconTextHSpacing: CGFloat = 8, title: String, padding: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16)) {
        super.init(frame: frame)
        
        iconImageView.image = icon
        iconImageView.isHidden = icon == nil
        
        titleLabel.text = title
        
        horizontalStack.spacing = iconTextHSpacing
        
        setupView()
        setupConstraints(padding: padding, iconSize: iconSize)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Métodos Públicos
    
    func addDescription(label: UILabel, spacingAfter spacing: CGFloat = 8) {
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        textStack.addArrangedSubview(label)
        textStack.addSpacing(spacing, after: label)
    }
    
    func addButton(button: UIButton, spacingAfter spacing: CGFloat = 8) {
        button.translatesAutoresizingMaskIntoConstraints = false
        textStack.addArrangedSubview(button)
        textStack.addSpacing(spacing, after: button)
    }
    
    // MARK: Métodos Privados
    
    private func setupView() {
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(iconImageView)
        horizontalStack.addArrangedSubview(textStack)
        textStack.addArrangedSubview(titleLabel)
        textStack.addSpacing(8, after: titleLabel)
    }
    
    private func setupConstraints(padding: UIEdgeInsets, iconSize: CGSize) {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor, constant: padding.top),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding.right),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding.bottom),
            
            iconImageView.heightAnchor.constraint(equalToConstant: iconSize.height),
            iconImageView.widthAnchor.constraint(equalToConstant: iconSize.width)
        ])
    }
}

struct PreviewLeftIconTitleAndDescriptionView: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            SideIconTitleAndDescriptionView(icon:  UIImage(systemName: "person.fill"), title: "Ajuda Dinheiro na hora! Após aprovado em até 24 horas o dinheiro cai na sua conta.")
        }.edgesIgnoringSafeArea(.all)
    }
}

