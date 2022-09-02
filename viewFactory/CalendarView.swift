//
//  CalendarView.swift
//  viewFactory
//
//  Created by Péricles Narbal on 27/04/22.
//

import UIKit
import SwiftUI

protocol CalendarViewProtocol: NSObject {
    func didUpdateDate(_ dateArray: [Date])
    func didTapMonthYearButton(_ sender: UIButton)
    func didTapDiaButton(_ sender: CalendarRoundedButton)
    func didTapPeriodoButton(_ sender: CalendarRoundedButton)
}

final class CalendarView: UIView {
    
    // MARK: Private Properties
    
    private let cellIdentifier = "cellAtPosition X:%d, Y:%d"
    
    private let weekDaysArray = ["dom", "seg", "ter", "qua", "qui", "sex", "sab"]
    
    private let calendar = CalendarHelper()
    
    private lazy var dynamicCollectionSize: (width: NSLayoutConstraint, height: NSLayoutConstraint) = {
        let height = calendarCollectionView.heightAnchor.constraint(equalToConstant: 0)
        let width = calendarCollectionView.widthAnchor.constraint(equalToConstant: 0)
        height.priority = .defaultLow
        return (width, height)
    }()
    
    private(set) var horizontalInset = CGFloat(16)
    
    private lazy var currentMonth = calendar.month(date: Date())
    private lazy var currentYear = calendar.year(date: Date())
    
    private lazy var monthMatrix: [[Int?]] = [] {
        didSet {
            updateMonthYearButton()
        }
    }
    
    private var daysInMonth = 0
    
    private let collectionViewLayout = CalendarCollectionViewLayout()
    
    private let calendarTopButtonsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = true
        return view
    }()
    
    private lazy var diaButton: CalendarRoundedButton = {
        let button = CalendarRoundedButton(type: UIButton.ButtonType.system)
        button.setTitle("Dia", for: .normal)
        button.titleLabel?.font = CalendarFontHelper.montserrat500s14
        button.addTarget(self, action: #selector(diaButtonAction(_:)), for: .touchUpInside)
        button.isSelected = true
        diaButtonAction(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var periodoButton: CalendarRoundedButton = {
        let button = CalendarRoundedButton(type: UIButton.ButtonType.system)
        button.setTitle("Período", for: .normal)
        button.titleLabel?.font = CalendarFontHelper.montserrat500s14
        button.addTarget(self, action: #selector(periodoButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let calendarHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var monthYearButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.titleLabel?.font = CalendarFontHelper.montsettat400s16
        button.addTarget(self, action: #selector(monthYearButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backMonthButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.backgroundColor = .white
        applyShadow(view: button)
        button.layer.cornerRadius = 16
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        } else {
            button.setTitle("<", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        button.tintColor = CalendarColorHelper.orange
        button.addTarget(self, action: #selector(backMonth), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextMonthButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.backgroundColor = .white
        applyShadow(view: button)
        button.layer.cornerRadius = 16
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        } else {
            button.setTitle(">", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        button.tintColor = CalendarColorHelper.orange
        button.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    private lazy var calendarCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        registerCells(collection: collection)
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()

    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [calendarTopButtonsView, calendarHeaderView, calendarCollectionView])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = CalendarColorHelper.lightGray
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    // MARK: Public Properties
    
    weak var delegate: CalendarViewProtocol?
    
    // MARK: Init Methods
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if frame.width == 0 { return }
        dynamicCollectionSize.height.constant = calculateCollectionHeigth()
        dynamicCollectionSize.width.constant = (frame.width - (horizontalInset * 2))
        dynamicCollectionSize.height.isActive = true
        dynamicCollectionSize.width.isActive = true
    }
    
    // MARK: Private Methods
    
    private func calculateCollectionHeigth() -> CGFloat {
        if frame.width == 0 { return 0 }
        let availableWidth: Double = (frame.width - (horizontalInset * 2))
        let maxNumColumns = 7
        let cellHeight: CGFloat = ((availableWidth) / Double(maxNumColumns)).rounded(.up)
        let height = cellHeight * CGFloat(calendarCollectionView.numberOfSections)
        return height
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        addSubview(contentStackView)
        calendarTopButtonsView.addSubview(diaButton)
        calendarTopButtonsView.addSubview(periodoButton)
        calendarHeaderView.addSubview(monthYearButton)
        calendarHeaderView.addSubview(nextMonthButton)
        calendarHeaderView.addSubview(backMonthButton)
        
        monthMatrix = createMonthBy(month: currentMonth, year: currentYear)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            calendarTopButtonsView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
        
            diaButton.leadingAnchor.constraint(equalTo: calendarTopButtonsView.leadingAnchor, constant: horizontalInset),
            diaButton.topAnchor.constraint(equalTo: calendarTopButtonsView.topAnchor, constant: 13),
            diaButton.bottomAnchor.constraint(equalTo: calendarTopButtonsView.bottomAnchor, constant: -12),

            periodoButton.leadingAnchor.constraint(equalTo: diaButton.trailingAnchor, constant: 4),
            periodoButton.topAnchor.constraint(equalTo: calendarTopButtonsView.topAnchor, constant: 13),
            periodoButton.bottomAnchor.constraint(equalTo: calendarTopButtonsView.bottomAnchor, constant: -12),
            
            calendarHeaderView.heightAnchor.constraint(equalToConstant: 58),
            calendarHeaderView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            
            monthYearButton.leadingAnchor.constraint(equalTo: calendarHeaderView.leadingAnchor, constant: horizontalInset),
            monthYearButton.centerYAnchor.constraint(equalTo: calendarHeaderView.centerYAnchor),

            nextMonthButton.trailingAnchor.constraint(equalTo: calendarHeaderView.trailingAnchor, constant: (horizontalInset * -1)),
            nextMonthButton.centerYAnchor.constraint(equalTo: calendarHeaderView.centerYAnchor),
            nextMonthButton.widthAnchor.constraint(equalToConstant: 32),
            nextMonthButton.heightAnchor.constraint(equalToConstant: 32),

            backMonthButton.trailingAnchor.constraint(equalTo: nextMonthButton.leadingAnchor, constant: -16),
            backMonthButton.centerYAnchor.constraint(equalTo: calendarHeaderView.centerYAnchor),
            backMonthButton.widthAnchor.constraint(equalToConstant: 32),
            backMonthButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    private func createMonthBy(month: Int, year: Int) -> [[Int?]] {
        var day = 1
        let contextDate = calendar.getDateBy(day: day, month: month, year: year)
        var weekday = calendar.weekDay(date: contextDate ?? Date())
        daysInMonth = calendar.daysInMonth(date: contextDate ?? Date())
        var monthMatrix: [[Int?]] = []
        
        for _ in 0...6 { monthMatrix.append([nil]) }
        
        for _ in 0...6 {
            for iWeekDay in 0...6 {
                if weekday == iWeekDay && day <= daysInMonth {
                    monthMatrix[iWeekDay].append(day)
                    weekday = weekday > 5 ? 0 : weekday + 1
                    day = day + 1
                } else {
                    monthMatrix[iWeekDay].append(nil)
                }
            }
            if day > daysInMonth { return monthMatrix }
        }
        
        return monthMatrix
    }
    
    private func applyShadow(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.3
    }
    
    @objc
    private func nextMonth() {
        currentMonth = currentMonth + 1
        if currentMonth == 13 {
            currentMonth = 1
            currentYear = currentYear + 1
        }
        monthMatrix = createMonthBy(month: currentMonth, year: currentYear)
    }
    
    @objc
    private func backMonth() {
        currentMonth = currentMonth - 1
        if currentMonth == 0 {
            currentMonth = 12
            currentYear = currentYear - 1
        }
        monthMatrix = createMonthBy(month: currentMonth, year: currentYear)
    }
    
    @objc
    private func diaButtonAction(_ sender: CalendarRoundedButton) {
        sender.isSelected = true
        periodoButton.isSelected = false
        if CalendarCollectionViewCell.numberOfMarked > 1 {
            CalendarCollectionViewCell.unselectLast()
            updateUI()
        }
        CalendarCollectionViewCell.maxNumberOfMarked = 1
        delegate?.didTapDiaButton(sender)
    }
    
    @objc
    private func periodoButtonAction(_ sender: CalendarRoundedButton) {
        sender.isSelected = true
        diaButton.isSelected = false
        CalendarCollectionViewCell.maxNumberOfMarked = 2
        delegate?.didTapPeriodoButton(sender)
    }
    
    @objc
    private func monthYearButtonAction(_ sender: UIButton) {
        delegate?.didTapMonthYearButton(sender)
    }
    
    private func updateMonthYearButton() {
        let buttonTitle = String(format: "%@, %d", calendar.monthString(month: currentMonth), currentYear)
        setTitleForMonthYearButton(title: buttonTitle)
        calendarCollectionView.reloadData()
        layoutSubviews()
    }
    
    private func registerCells(collection: UICollectionView) {
        for bar in 0...6 {
            for column in 0...6 {
                collection.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: String(format: cellIdentifier, bar, column))
            }
        }
    }
    
    private func setTitleForMonthYearButton(title: String) {
        let attrs = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0),
            NSAttributedString.Key.foregroundColor : CalendarColorHelper.purple,
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        let attributedText = NSMutableAttributedString(string: title, attributes:attrs)
        monthYearButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    private func updateUI() {
        calendarCollectionView.reloadData()
        delegate?.didUpdateDate(CalendarCollectionViewCell.selectedHistoryArraySorted)
    }
}

extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return monthMatrix.first?.count ?? 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(format: cellIdentifier, indexPath.section, indexPath.row), for: indexPath) as? CalendarCollectionViewCell else { return UICollectionViewCell() }
        
        cell.clearAll()
        
        if indexPath.section == 0 {
            cell.dayLabel.text = weekDaysArray[indexPath.row]
            cell.isUserInteractionEnabled = false
            cell.contentView.alpha = 1
            cell.dayLabel.font = CalendarFontHelper.lato400s14
            return cell
        }
        
        if let day = monthMatrix[indexPath.row][indexPath.section],
           let contextDate = calendar.getDateBy(day: day, month: currentMonth, year: currentYear) {
            
            cell.setupCell(day: day, month: currentMonth, year: currentYear)
            
            _ = CalendarCollectionViewCell.selectedHistoryArraySorted.map {
                if $0 == cell.toDate() { cell.setOrangeMark() }
            }
            
            if CalendarCollectionViewCell.numberOfMarked > 1 {
                let selectedHistory = CalendarCollectionViewCell.selectedHistoryArraySorted
                
                if indexPath.row == 0 { cell.roundGlowViewTo(side: .left) }
                if indexPath.row == 6 { cell.roundGlowViewTo(side: .right) }
                
                if cell.toDate() == selectedHistory[0] { cell.roundGlowViewTo(side: .left) }
                if cell.toDate() == selectedHistory[1] { cell.roundGlowViewTo(side: .right) }
                
                if (cell.toDate() >= selectedHistory[0]) && (cell.toDate() <= selectedHistory[1]) {
                    cell.isGlowing = true
                }
            }
            
            if calendar.isPastDate(date: contextDate) {
                cell.isUserInteractionEnabled = false
            } else {
                cell.isUserInteractionEnabled = true
            }
            
        } else {
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = (collectionView.cellForItem(at: indexPath)) as? CalendarCollectionViewCell else { return }
        cell.isMarked = !cell.isMarked
        updateUI()
    }
}

