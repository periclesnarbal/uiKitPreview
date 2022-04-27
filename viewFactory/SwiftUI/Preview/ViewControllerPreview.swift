//
//  ViewControllerPreview.swift
//  viewFactory
//
//  Created by Péricles Narbal on 27/04/22.
//

import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable {
    
    let viewControllerBuilder: () -> UIViewController
    
    init(_ viewControllerBuilder: @escaping () -> UIViewController ) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewControllerBuilder()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Not needed
    }
}

