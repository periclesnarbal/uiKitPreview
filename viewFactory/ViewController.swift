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
        setupNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("abel"), object: nil)
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("abel"), object: nil, queue: nil) {
                notification in
                print("abel")
        }
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
