//
//  CalendarCollectionViewCell.swift
//  viewFactory
//
//  Created by Pericles Narbal Da Costa De Oliveira (ACT CONSULTORIA EM TECNOLOGIA LTDA – DITEC – CE) on 22/08/22.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    // MARK: Private Properties
    
    private var day: Int? {
        didSet {
            if let day = day {
                dayLabel.text = "\(day)"
            } else {
                dayLabel.text = ""
            }
        }
    }
    
    private var month: Int?
    private var year: Int?
    
    private(set) var dayLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = CalendarColorHelper.blackText2
        label.font = CalendarFontHelper.montserrat500s16
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let glowView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private static var selectedCellsArray: [CalendarCollectionViewCell] = []
    
    private static var selectedHistoryArray: [Date] = [] {
        didSet {
            selectedHistoryArraySorted = selectedHistoryArray.sorted()
        }
    }
    
    // MARK: Public Properties
    
    static var selectedHistoryArraySorted: [Date] = []
    
    static var maxNumberOfMarked = 1
    
    static var numberOfMarked: Int = 0 {
        didSet {
            if numberOfMarked > CalendarCollectionViewCell.maxNumberOfMarked {
                unselectLast()
            }
        }
    }
    
    override var isUserInteractionEnabled: Bool {
        didSet {
            if isUserInteractionEnabled {
                contentView.alpha = 1
            } else {
                contentView.alpha = 0.5
            }
        }
    }
    
    private var editingMode = true
    
    var isMarked: Bool = false {
        didSet {
            if editingMode {
                didChangeValueIsMarked()
            }
        }
    }
    
    var isGlowing: Bool = false {
        didSet {
            if isGlowing {
                glowView.backgroundColor = CalendarColorHelper.lightOrange
            } else {
                glowView.backgroundColor = .clear
                glowView.layer.cornerRadius = 0
            }
        }
    }
    
    enum roundOrientation {
        case left
        case right
        case full
    }
    
    // MARK: Init Methods
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setConstraints()
    }
    
    // MARK: Public Methods
    
    func setupCell(day: Int, month: Int, year: Int) {
        self.day = day; self.month = month; self.year = year
    }
    
    func setOrangeMark(editingMode: Bool = false) {
        self.editingMode = editingMode
        isMarked = true
        contentView.backgroundColor = CalendarColorHelper.orange
        dayLabel.textColor = .white
        self.editingMode = true
    }
    
    func clearAll(editingMode: Bool = false) {
        self.editingMode = editingMode
        contentView.backgroundColor = .clear
        dayLabel.textColor = CalendarColorHelper.blackText2
        day = nil
        isGlowing = false
        isMarked = false
        self.editingMode = true
    }
    
    func toString() -> String {
        guard let day = day, let month = month, let year = year else { return "" }
        return String(format: "%02d/%02d/%d", day, month, year)
    }
    
    func toDate() -> Date {
        guard let day = day, let month = month, let year = year else { return Date() }
        return CalendarHelper.getDateBy(day: day, month: month, year: year) ?? Date()
    }
    
    static func unselectLast() {
        selectedCellsArray.last?.isMarked = false
    }
    
    func roundGlowViewTo(side: roundOrientation) {
        let cornerRadius = (frame.height * 0.7) / 2
        switch side {
        case .left:
            CalendarUtils.addPartialCornerRadius(
                view: glowView, cornerRadius: cornerRadius, corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner], legacyCorners: [.topLeft, .bottomLeft])
        case .right:
            CalendarUtils.addPartialCornerRadius(
                view: glowView, cornerRadius: cornerRadius, corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], legacyCorners: [.topRight, .bottomRight])
        case .full:
            CalendarUtils.addPartialCornerRadius(
                view: glowView, cornerRadius: cornerRadius, corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner], legacyCorners: [.bottomLeft, .topLeft, .topRight, .bottomRight])
        }
    }
    
    
    override func isEqual(_ object: Any?) -> Bool {
        var equal = false
        guard let object = object as? CalendarCollectionViewCell else { return false }
        if  self.day == object.day     &&
            self.month == object.month &&
            self.year == object.year {
                equal = true
        }
        return equal
    }
    
    // MARK: Private Methods
    
    private func setupView() {
        backgroundColor = .clear
        contentView.layer.cornerRadius = frame.width / 2
        contentView.addSubview(dayLabel)
        addSubview(glowView)
        bringSubviewToFront(contentView)
    }
    
    private func didChangeValueIsMarked() {
        if isMarked {
            CalendarCollectionViewCell.numberOfMarked = CalendarCollectionViewCell.numberOfMarked + 1
            CalendarCollectionViewCell.selectedCellsArray.append(self)
            CalendarCollectionViewCell.selectedHistoryArray.append(toDate())
        } else {
            CalendarCollectionViewCell.numberOfMarked = CalendarCollectionViewCell.numberOfMarked - 1
            guard let index = CalendarCollectionViewCell.selectedCellsArray.firstIndex(of: self) else { return clearAll() }
            CalendarCollectionViewCell.selectedCellsArray.remove(at: index)
            CalendarCollectionViewCell.selectedHistoryArray.remove(at: index)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            glowView.centerXAnchor.constraint(equalTo: centerXAnchor),
            glowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            glowView.widthAnchor.constraint(equalTo: widthAnchor),
            glowView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
