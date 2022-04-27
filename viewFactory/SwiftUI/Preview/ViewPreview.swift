//
//  ViewPreview.swift
//  viewFactory
//
//  Created by Péricles Narbal on 27/04/22.
//

import SwiftUI

struct ViewPreview: UIViewRepresentable {
    let viewBuilder: () -> UIView

    init(_ viewBuilder: @escaping () -> UIView) {
        self.viewBuilder = viewBuilder
    }

    func makeUIView(context: Context) -> some UIView {
        viewBuilder()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Not needed
    }
}
