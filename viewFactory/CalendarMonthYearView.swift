//
//  CalendarMonthYearView.swift
//  viewFactory
//
//  Created by Pericles Narbal Da Costa De Oliveira (ACT CONSULTORIA EM TECNOLOGIA LTDA – DITEC – CE) on 30/08/22.
//

import UIKit

protocol CalendarMonthYearViewProtocol: NSObject {
    func didSelectMonthAndYear(month: Int, year: Int)
    func invalidSelection()
}

class CalendarMonthYearView: UIView {
    
    // MARK: Private Properties
    
    private let cellIdentifier = "monthCell"
    
    private(set) var horizontalInset = CGFloat(16)
    
    private lazy var currentMonth = 0 {
        didSet {
            if currentMonth != 0 {
                delegate?.didSelectMonthAndYear(month: currentMonth, year: currentYear)
            } else {
                delegate?.invalidSelection()
            }
        }
    }
    
    private lazy var currentYear = CalendarHelper.year(date: Date())
    
    private lazy var dynamicCollectionSize: (width: NSLayoutConstraint, height: NSLayoutConstraint) = {
        let height = monthYearCollectionView.heightAnchor.constraint(equalToConstant: 0)
        let width = monthYearCollectionView.widthAnchor.constraint(equalToConstant: 0)
        height.priority = .defaultLow
        return (width, height)
    }()
    
    private let collectionViewLayout = CalendarMonthYearCollectionViewLayout()
    
    private let topHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private(set) var choiceMesYearLabel: UILabel = {
        let label = UILabel()
        label.text = "Escolha mês e ano para exibir"
        label.font = CalendarFontHelper.montserrat700s16
        label.textColor = CalendarColorHelper.blackText2
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mesLabel: UILabel = {
        let label = UILabel()
        label.text = "Mês"
        label.font = CalendarFontHelper.lato700s16
        label.textColor = CalendarColorHelper.blackText
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let middleHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let anoLabel: UILabel = {
        let label = UILabel()
        label.text = "Ano"
        label.font = CalendarFontHelper.lato700s16
        label.textColor = CalendarColorHelper.blackText
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var monthYearCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collection.register(CalendarMonthYearCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var anoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: createYearButtons())
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topHeaderView, monthYearCollectionView, middleHeaderView, anoStackView])
        stack.axis = .vertical
        stack.backgroundColor = .white
        stack.distribution = .fill
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: Public Properties
    
    weak var delegate: CalendarMonthYearViewProtocol?
    
    // MARK: Init Methods
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        setConstraints()
        layoutSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setConstraints()
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if frame.width == 0 { return }
        dynamicCollectionSize.height.constant = calculateCollectionHeigth()
        dynamicCollectionSize.height.isActive = true
        dynamicCollectionSize.width.isActive = true
    }
    
    // MARK: Private Methods
    
    private func setupView() {
        backgroundColor = .clear
        
        addSubview(contentStackView)
        topHeaderView.addSubview(choiceMesYearLabel)
        topHeaderView.addSubview(mesLabel)
        middleHeaderView.addSubview(anoLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            choiceMesYearLabel.topAnchor.constraint(equalTo: topHeaderView.topAnchor, constant: 16),
            choiceMesYearLabel.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: horizontalInset),
            choiceMesYearLabel.heightAnchor.constraint(equalToConstant: 24),
            
            monthYearCollectionView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: horizontalInset),
            monthYearCollectionView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: (horizontalInset * -1)),

            mesLabel.topAnchor.constraint(equalTo: choiceMesYearLabel.bottomAnchor, constant: 8),
            mesLabel.leadingAnchor.constraint(equalTo: topHeaderView.leadingAnchor, constant: horizontalInset),
            mesLabel.bottomAnchor.constraint(equalTo: topHeaderView.bottomAnchor, constant: -8),
            mesLabel.heightAnchor.constraint(equalToConstant: 24),

            anoLabel.topAnchor.constraint(equalTo: middleHeaderView.topAnchor, constant: 20),
            anoLabel.leadingAnchor.constraint(equalTo: middleHeaderView.leadingAnchor, constant: horizontalInset),
            anoLabel.bottomAnchor.constraint(equalTo: middleHeaderView.bottomAnchor, constant: -8),
            anoLabel.heightAnchor.constraint(equalToConstant: 24),
            
            anoStackView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: horizontalInset)
        ])
    }
    
    private func calculateCollectionHeigth() -> CGFloat {
        if frame.width == 0 { return 0 }
        let totalWidth = (frame.width - CGFloat(horizontalInset * 2))
        let cellWidth = CGFloat(90)
        let numberOfRows = ((12 * cellWidth) / totalWidth).rounded(.up)
        let heigth = numberOfRows * 47
        return heigth
    }
    
    private func createYearButtons() -> [CalendarRoundedButton] {
        var arrayButton: [CalendarRoundedButton] = []
        for increment in 0...2 {
            let button = CalendarRoundedButton()
            button.setTitle("\(currentYear + increment)", for: .normal)
            button.titleLabel?.font = CalendarFontHelper.montserrat500s14
            button.addTarget(self, action: #selector(yearButtonActions(_:)), for: .touchUpInside)
            if increment == 0 { button.isSelected = true }
            arrayButton.append(button)
        }
        return arrayButton
    }
    
    @objc
    private func yearButtonActions(_ sender: CalendarRoundedButton) {
        unselectAllYearButtons()
        sender.isSelected = true
        if let valueString = sender.currentTitle,
           let valueNumber = Int(valueString) {
            currentYear = valueNumber
            currentMonth = 0
            monthYearCollectionView.reloadData()
        }
    }
    
    private func unselectAllYearButtons() {
        guard let arrayButton = anoStackView.arrangedSubviews as? [CalendarRoundedButton] else { return }
        arrayButton.forEach({ $0.isSelected = false })
    }
}

extension CalendarMonthYearView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CalendarMonthYearCell else { return UICollectionViewCell() }
        cell.setupCell(month: indexPath.row + 1, year: currentYear)
        
        if CalendarHelper.isPastDate(date: cell.getDate(), granularity: .month) {
            cell.isUserInteractionEnabled = false
        } else {
            cell.isUserInteractionEnabled = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentMonth = indexPath.row + 1
    }
}
