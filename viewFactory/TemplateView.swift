//
//  TemplateView.swift
//  viewFactory
//
//  Created by Péricles Narbal on 27/04/22.
//

import UIKit
import SwiftUI

final class TemplateView: UIView {
    
    let centerButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(centerButtonAction), for: .touchUpInside)
        button.setTitle("abel", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("abel"), object: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .red
        addSubview(centerButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            centerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            centerButton.heightAnchor.constraint(equalToConstant: 50),
            centerButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc
    private func centerButtonAction() {
        NotificationCenter.default.post(name: Notification.Name("abel"), object: nil)
    }
}

struct PreviewView: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            TemplateView()
        }.edgesIgnoringSafeArea(.all)
    }
}

