//
//  ViewController.swift
//  viewFactory
//
//  Created by Péricles Narbal on 27/04/22.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var contentView = TemplateView(frame: view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
    }
}

import SwiftUI
struct PreviewViewController: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            ViewController()
        }.edgesIgnoringSafeArea(.all)
    }
}
