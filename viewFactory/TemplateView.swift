//
//  TemplateView.swift
//  viewFactory
//
//  Created by Péricles Narbal on 27/04/22.
//

import UIKit
import SwiftUI

final class TemplateView: UIView {

    //MARK: Propriedades
    
    private let cabecalhoTituloLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Capital na\nMão Bmg" //TODO: ADICIONAR LOCALIZABLE
//        lbl.font = UIFont() //TODO: ADICIONAR FONTE
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cabecalhoImageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .cyan
        img.contentMode = .scaleAspectFill
        img.image = UIImage(systemName: "person.fill") //TODO: ADICIONAR IMAGEM
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var cabecalhoTopView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.addSubview(cabecalhoTituloLabel)
        view.addSubview(cabecalhoImageView)
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cabecalhoDescriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "É o Crédito emergencial para empresas.\nParcelas que cabem no seu bolso e valores calculados, com base no seu faturamento e transações na sua maquininha de cartão.\nÓtimas condições  utilizando seus recebíveis como garantia." //TODO: ADICIONAR LOCALIZABLE
//        lbl.font = UIFont() //TODO: ADICIONAR FONTE
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var cabecalhoMiddleView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.addSubview(cabecalhoDescriptionLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cabecalhoOrangeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("BUTTON", for: .normal)
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var cabecalhoBottonView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.addSubview(cabecalhoOrangeButton)
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cabecalhoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cabecalhoTopView, cabecalhoMiddleView, cabecalhoBottonView])
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configuraView()
        configuraConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configuraView()
        configuraConstraints()
    }
    
    private func configuraView() {
        backgroundColor = .yellow
        addSubview(cabecalhoStackView)
    }
    
    private func configuraConstraints() {
        NSLayoutConstraint.activate([
            cabecalhoStackView.topAnchor.constraint(equalTo: topAnchor),
            cabecalhoStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cabecalhoStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            cabecalhoTopView.heightAnchor.constraint(equalToConstant: 170),
            
            cabecalhoTituloLabel.topAnchor.constraint(equalTo: cabecalhoTopView.topAnchor),
            cabecalhoTituloLabel.leadingAnchor.constraint(equalTo: cabecalhoTopView.leadingAnchor, constant: 16),
            cabecalhoTituloLabel.bottomAnchor.constraint(equalTo: cabecalhoTopView.bottomAnchor),
            cabecalhoTituloLabel.widthAnchor.constraint(equalToConstant: 157),
            
            cabecalhoImageView.topAnchor.constraint(equalTo: cabecalhoTopView.topAnchor),
            cabecalhoImageView.leadingAnchor.constraint(equalTo: cabecalhoTituloLabel.trailingAnchor),
            cabecalhoImageView.trailingAnchor.constraint(equalTo: cabecalhoTopView.trailingAnchor),
            cabecalhoImageView.bottomAnchor.constraint(equalTo: cabecalhoTopView.bottomAnchor),
            
            cabecalhoDescriptionLabel.topAnchor.constraint(equalTo: cabecalhoMiddleView.topAnchor),
            cabecalhoDescriptionLabel.leadingAnchor.constraint(equalTo: cabecalhoMiddleView.leadingAnchor, constant: 16),
            cabecalhoDescriptionLabel.trailingAnchor.constraint(equalTo: cabecalhoMiddleView.trailingAnchor, constant: -16),
            cabecalhoDescriptionLabel.bottomAnchor.constraint(equalTo: cabecalhoMiddleView.bottomAnchor),
            
            cabecalhoBottonView.heightAnchor.constraint(equalToConstant: 96),
            
            cabecalhoOrangeButton.topAnchor.constraint(equalTo: cabecalhoBottonView.topAnchor, constant: 24),
            cabecalhoOrangeButton.leadingAnchor.constraint(equalTo: cabecalhoBottonView.leadingAnchor, constant: 24),
            cabecalhoOrangeButton.trailingAnchor.constraint(equalTo: cabecalhoBottonView.trailingAnchor, constant: -24),
            cabecalhoOrangeButton.bottomAnchor.constraint(equalTo: cabecalhoBottonView.bottomAnchor, constant: -24)
        ])
    }
}

struct PreviewView: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            TemplateView()
        }.edgesIgnoringSafeArea(.all)
    }
}

