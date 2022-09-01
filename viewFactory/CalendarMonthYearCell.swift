//
//  CalendarMonthYearCell.swift
//  viewFactory
//
//  Created by Pericles Narbal Da Costa De Oliveira (ACT CONSULTORIA EM TECNOLOGIA LTDA – DITEC – CE) on 30/08/22.
//

import UIKit

class CalendarMonthYearCell: UICollectionViewCell {
    
    // MARK: Private Properties
    
    private let monthArray: [String] = ["", "Janeiro", "Fevereiro", "Março",
                                        "Abril", "Maio", "Junho",
                                        "Julho", "Agosto", "Setembro",
                                        "Outubro", "Novembro", "Dezembro"]
    
    private let calendar = CalendarHelper()
    
    private var month: Int? {
        didSet {
            if let month = month {
                if month > 12 { return }
                monthLabel.text = monthArray[month]
            }
        }
    }
    
    private var year: Int?

    private(set) var monthLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = CalendarColorHelper.blackText
        label.font = CalendarFontHelper.montserrat500s14
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Public Properties
    
    override var isUserInteractionEnabled: Bool {
        didSet {
            if isUserInteractionEnabled {
                enableCell()
            } else {
                disableCell()
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selectCell()
            } else {
                unselectCell()
            }
        }
    }
    
    // MARK: Init Methods
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Public Methods
    
    func setupCell(month: Int, year: Int) {
        self.month = month; self.year = year
    }
    
    func selectCell() {
        contentView.backgroundColor = CalendarColorHelper.orange
        monthLabel.textColor = .white
        contentView.layer.borderWidth = 0
    }
    
    func unselectCell() {
        contentView.backgroundColor = .white
        monthLabel.textColor = CalendarColorHelper.blackText
        contentView.layer.borderWidth = 1
    }
    
    func getDate() -> Date {
        guard let month = month, let year = year else { return Date() }
        return calendar.getDateBy(day: 01, month: month, year: year) ?? Date()
    }
    
    // MARK: Private Methods
    
    private func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = CalendarColorHelper.gray.cgColor
        contentView.layer.cornerRadius = (frame.height - 10) / 2
        contentView.addSubview(monthLabel)
    }
    
    private func disableCell() {
        contentView.backgroundColor = CalendarColorHelper.gray
        monthLabel.textColor = CalendarColorHelper.blackText
        contentView.alpha = 0.5
        contentView.layer.borderWidth = 0
    }
    
    private func enableCell() {
        contentView.backgroundColor = .white
        monthLabel.textColor = CalendarColorHelper.blackText
        contentView.alpha = 1
        contentView.layer.borderWidth = 1
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            monthLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            monthLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            monthLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            monthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            monthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            monthLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
