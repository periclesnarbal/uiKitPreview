//
//  TemplateView.swift
//  viewFactory
//
//  Created by Péricles Narbal on 27/04/22.
//

import UIKit
import SwiftUI

final class TemplateView: UIView {

    // MARK: Propriedades
    
    private let cabecalhoTituloLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Capital na\nMão Bmg" // TODO: ADICIONAR LOCALIZABLE
//        lbl.font = UIFont() // TODO: ADICIONAR FONTE
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cabecalhoImageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .cyan
        img.contentMode = .scaleAspectFill
        img.image = UIImage(systemName: "person.fill") // TODO: ADICIONAR IMAGEM
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private lazy var cabecalhoTopoView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.addSubview(cabecalhoTituloLabel)
        view.addSubview(cabecalhoImageView)
        return view
    }()
    
    private let cabecalhoDescriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "É o Crédito emergencial para empresas.\nParcelas que cabem no seu bolso e valores calculados, com base no seu faturamento e transações na sua maquininha de cartão.\nÓtimas condições  utilizando seus recebíveis como garantia." // TODO: ADICIONAR LOCALIZABLE
//        lbl.font = UIFont() // TODO: ADICIONAR FONTE
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var cabecalhoMeioView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.addSubview(cabecalhoDescriptionLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cabecalhoOrangeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("BUTTON", for: .normal) // TODO: ADICIONAR LOCALIZABLE
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var cabecalhoBaixoView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.addSubview(cabecalhoOrangeButton)
        return view
    }()
    
    private lazy var cabecalhoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cabecalhoTopoView, cabecalhoMeioView, cabecalhoBaixoView])
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let corpoConteudoTituloLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Vantagens" // TODO: ADICIONAR LOCALIZABLE
//        lbl.font = UIFont() // TODO: ADICIONAR FONTE
        lbl.numberOfLines = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let bastaoLaranjaView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var corpoConteudoCabecalhoView: UIView = {
        let view = UIView()
        view.addSubview(corpoConteudoTituloLabel)
        view.addSubview(bastaoLaranjaView)
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dinheiroNaHoraView: LeftIconTitleAndDescriptionView = {
        let view = LeftIconTitleAndDescriptionView(icon: UIImage(systemName: "person.fill"),
                                                   iconTextHSpacing: 18,
                                                   title: "Ajuda Dinheiro na hora! Após aprovado em até 24 horas o dinheiro cai na sua conta.",
                                                   padding: UIEdgeInsets(top: 0, left: 18, bottom: -16, right: -16))
        view.titleLabel.textWithBold(boldTexts: ["Ajuda Dinheiro na hora!"], boldFont: UIFont.boldSystemFont(ofSize: 16), boldColor: .black)
        return view
    }()
    
    private let calendarioPlanejamentoView: LeftIconTitleAndDescriptionView = {
        let view = LeftIconTitleAndDescriptionView(icon: UIImage(systemName: "person.fill"),
                                                   iconTextHSpacing: 18,
                                                   title: "Para não sair do planejamento: parcelas fixas em 3x, 6x ou 12x conforme o plano do seu negócio.",
                                                   padding: UIEdgeInsets(top: 0, left: 18, bottom: -16, right: -16))
        view.titleLabel.textWithBold(boldTexts: ["Para não sair do planejamento:"], boldFont: UIFont.boldSystemFont(ofSize: 16), boldColor: .black)
        return view
    }()
    
    private let segurancaPagamentoView: LeftIconTitleAndDescriptionView = {
        let view = LeftIconTitleAndDescriptionView(icon: UIImage(systemName: "person.fill"),
                                                   iconTextHSpacing: 18,
                                                   title: "Segurança na hora de pagar! Seus recebíveis são usados como garantia no seu empréstimo.",
                                                   padding: UIEdgeInsets(top: 0, left: 18, bottom: -16, right: -16))
        view.titleLabel.textWithBold(boldTexts: ["Segurança na hora de pagar!"], boldFont: UIFont.boldSystemFont(ofSize: 16), boldColor: .black)
        return view
    }()
    
    private lazy var corpoConteudoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dinheiroNaHoraView, calendarioPlanejamentoView, segurancaPagamentoView])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var corpoConteudoView: UIView = {
        let view = UIView()
        view.addSubview(corpoConteudoCabecalhoView)
        view.addSubview(corpoConteudoStackView)
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rodapeOrangeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("BUTTON", for: .normal) // TODO: ADICIONAR LOCALIZABLE
        btn.backgroundColor = .orange
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var rodapeView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.addSubview(rodapeOrangeButton)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(corpoConteudoView)
        addSubview(rodapeView)
    }
    
    private func configuraConstraints() {
        NSLayoutConstraint.activate([
            cabecalhoStackView.topAnchor.constraint(equalTo: topAnchor),
            cabecalhoStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cabecalhoStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            cabecalhoTopoView.heightAnchor.constraint(equalToConstant: 170),
            
            cabecalhoTituloLabel.topAnchor.constraint(equalTo: cabecalhoTopoView.topAnchor),
            cabecalhoTituloLabel.leadingAnchor.constraint(equalTo: cabecalhoTopoView.leadingAnchor, constant: 16),
            cabecalhoTituloLabel.bottomAnchor.constraint(equalTo: cabecalhoTopoView.bottomAnchor),
            cabecalhoTituloLabel.widthAnchor.constraint(equalToConstant: 157),
            
            cabecalhoImageView.topAnchor.constraint(equalTo: cabecalhoTopoView.topAnchor),
            cabecalhoImageView.leadingAnchor.constraint(equalTo: cabecalhoTituloLabel.trailingAnchor),
            cabecalhoImageView.trailingAnchor.constraint(equalTo: cabecalhoTopoView.trailingAnchor),
            cabecalhoImageView.bottomAnchor.constraint(equalTo: cabecalhoTopoView.bottomAnchor),
            
            cabecalhoDescriptionLabel.topAnchor.constraint(equalTo: cabecalhoMeioView.topAnchor),
            cabecalhoDescriptionLabel.leadingAnchor.constraint(equalTo: cabecalhoMeioView.leadingAnchor, constant: 16),
            cabecalhoDescriptionLabel.trailingAnchor.constraint(equalTo: cabecalhoMeioView.trailingAnchor, constant: -16),
            cabecalhoDescriptionLabel.bottomAnchor.constraint(equalTo: cabecalhoMeioView.bottomAnchor),
            
            cabecalhoOrangeButton.topAnchor.constraint(equalTo: cabecalhoBaixoView.topAnchor, constant: 24),
            cabecalhoOrangeButton.leadingAnchor.constraint(equalTo: cabecalhoBaixoView.leadingAnchor, constant: 24),
            cabecalhoOrangeButton.trailingAnchor.constraint(equalTo: cabecalhoBaixoView.trailingAnchor, constant: -24),
            cabecalhoOrangeButton.bottomAnchor.constraint(equalTo: cabecalhoBaixoView.bottomAnchor, constant: -24),
            
            corpoConteudoView.topAnchor.constraint(equalTo: cabecalhoStackView.bottomAnchor, constant: 16),
            corpoConteudoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            corpoConteudoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
             
            corpoConteudoCabecalhoView.topAnchor.constraint(equalTo: corpoConteudoView.topAnchor),
            corpoConteudoCabecalhoView.leadingAnchor.constraint(equalTo: corpoConteudoView.leadingAnchor),
            corpoConteudoCabecalhoView.trailingAnchor.constraint(equalTo: corpoConteudoView.trailingAnchor),

            corpoConteudoTituloLabel.topAnchor.constraint(equalTo: corpoConteudoCabecalhoView.topAnchor, constant: 23),
            corpoConteudoTituloLabel.leadingAnchor.constraint(equalTo: corpoConteudoCabecalhoView.leadingAnchor, constant: 16),
            corpoConteudoTituloLabel.trailingAnchor.constraint(equalTo: corpoConteudoCabecalhoView.trailingAnchor, constant: -16),

            bastaoLaranjaView.topAnchor.constraint(equalTo: corpoConteudoTituloLabel.bottomAnchor, constant: 12),
            bastaoLaranjaView.leadingAnchor.constraint(equalTo: corpoConteudoCabecalhoView.leadingAnchor, constant: 16),
            bastaoLaranjaView.bottomAnchor.constraint(equalTo: corpoConteudoCabecalhoView.bottomAnchor, constant: -26),
            bastaoLaranjaView.widthAnchor.constraint(equalToConstant: 32),
            bastaoLaranjaView.heightAnchor.constraint(equalToConstant: 4),

            corpoConteudoStackView.topAnchor.constraint(equalTo: corpoConteudoCabecalhoView.bottomAnchor),
            corpoConteudoStackView.leadingAnchor.constraint(equalTo: corpoConteudoView.leadingAnchor),
            corpoConteudoStackView.trailingAnchor.constraint(equalTo: corpoConteudoView.trailingAnchor),
            corpoConteudoStackView.bottomAnchor.constraint(equalTo: corpoConteudoView.bottomAnchor),
            
            rodapeView.topAnchor.constraint(equalTo: corpoConteudoView.bottomAnchor),
            rodapeView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rodapeView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rodapeView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rodapeOrangeButton.topAnchor.constraint(equalTo: rodapeView.topAnchor, constant: 24),
            rodapeOrangeButton.leadingAnchor.constraint(equalTo: rodapeView.leadingAnchor, constant: 24),
            rodapeOrangeButton.trailingAnchor.constraint(equalTo: rodapeView.trailingAnchor, constant: -24),
            rodapeOrangeButton.bottomAnchor.constraint(equalTo: rodapeView.bottomAnchor, constant: -24)
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

