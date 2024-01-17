//
//  TypeCell.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 14.01.2024.
//

import UIKit

final class TypeCell: UITableViewCell {
    
    static let identifier = "TypeCell"
    
    //MARK: Private properties
    private lazy var currentTypeLabel = makeLabel(withTitle: "Тип заметки", textAlignment: .left)
    private lazy var chooseTypeLabel = makeLabel(withTitle: "➤", textColor: .systemGray, textAlignment: .right)
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Public method
    func configure(_ taskType: String) {
        chooseTypeLabel.text = "\(taskType) ➤"
    }
}

//MARK: Private methods
private extension TypeCell {
    func commonInit() {
        setupCurrentTypeLabelConstraints()
        setupChooseTypeLabelConstraints()
    }
    
    func makeLabel(withTitle title: String, textColor: UIColor? = .black, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
    
    func setupCurrentTypeLabelConstraints() {
        contentView.addSubview(currentTypeLabel)
        currentTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentTypeLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            currentTypeLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            currentTypeLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
        currentTypeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func setupChooseTypeLabelConstraints() {
        addSubview(chooseTypeLabel)
        chooseTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseTypeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            chooseTypeLabel.leadingAnchor.constraint(equalTo: currentTypeLabel.trailingAnchor),
            chooseTypeLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
}
