//
//  ViewController.swift
//  viewFactory
//
//  Created by Péricles Narbal on 27/04/22.
//

import UIKit

final class ViewController: UIViewController {
    
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
//            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

extension ViewController: CalendarViewProtocol {
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
