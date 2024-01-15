//
//  SwitchCell.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 15.01.2024.
//

import UIKit

final class SwitchCell: UITableViewCell {
    
    static let identifier = "SwitchCell"
    
    //MARK: Private properties
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        return label
    }()
    
    private let typeSwitch: UISwitch = {
        let typeSwitch = UISwitch()
        typeSwitch.isOn = true
        return typeSwitch
    }()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods
private extension SwitchCell {
    
    func commonInit() {
        setupTypeLabelConstraints()
        setupTypeSwitchConstraints()
    }
    
    func setupTypeLabelConstraints() {
        contentView.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            typeLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    func setupTypeSwitchConstraints() {
        contentView.addSubview(typeSwitch)
        typeSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            typeSwitch.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
}
