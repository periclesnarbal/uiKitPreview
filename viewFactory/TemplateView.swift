//
//  TemplateView.swift
//  viewFactory
//
//  Created by Péricles Narbal on 27/04/22.
//

import UIKit
import SwiftUI

final class TemplateView: UIView {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .red
    }
}

struct PreviewView: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            TemplateView()
        }.edgesIgnoringSafeArea(.all)
    }
}

