//
//  ViewController.swift
//  viewFactory
//
//  Created by Péricles Narbal on 27/04/22.
//

import UIKit

final class ViewController: UIViewController {
    
    private lazy var tapMeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.setTitle("tap me", for: .normal)
        button.center = self.view.center
        button.addTarget(self, action: #selector(tapMeButtonAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.addSubview(tapMeButton)
    }
    
    @objc func tapMeButtonAction() {
        let secondVC = SecondViewController()
        present(secondVC, animated: true)
    }
}

final class SecondViewController: UIViewController {
    
    private lazy var contentView = CalendarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
    }
    
    func setupView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.delegate = self
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
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

//extension ViewController: CalendarMonthYearViewProtocol {
//
//    func didSelectMonthAndYear(month: Int, year: Int) {
//        print("Selected: \(month)/\(year)")
//    }
//
//    func invalidSelection() {
//        print("Selecione o mês")
//    }
//
//}

extension SecondViewController: CalendarViewProtocol {
    func didUpdateDate(_ dateArray: [Date]) {
        print("didUpdateDate: \(dateArray)")
    }

    func didTapMonthYearButton(_ sender: UIButton) {
        print("didTapMonthYearButton: \(sender.titleLabel?.text)")
    }

    func didTapDiaButton(_ sender: CalendarRoundedButton) {
        print("didTapDiaButton: \(sender.titleLabel?.text)")
    }

    func didTapPeriodoButton(_ sender: CalendarRoundedButton) {
        print("didTapPeriodoButton: \(sender.titleLabel?.text)")
    }

}
