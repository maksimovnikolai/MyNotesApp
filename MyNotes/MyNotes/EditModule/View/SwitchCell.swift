//
//  SwitchCell.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 15.01.2024.
//

import UIKit

protocol SwitchCellDelegate: AnyObject {
    func updateTaskStatus(_ switchCell: SwitchCell, _ status: TaskStatus)
}

final class SwitchCell: UITableViewCell {
    
    static let identifier = "SwitchCell"
    
    weak var delegate: SwitchCellDelegate?
    
    //MARK: Private properties
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Выполнена"
        return label
    }()
    
    private let typeSwitch: UISwitch = {
        let typeSwitch = UISwitch()
        return typeSwitch
    }()
    
    private var currentStatus: TaskStatus = .planned
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public method
    func configure(with status: TaskStatus) {
        currentStatus = status
        typeSwitch.isOn = status == .completed ? true : false
    }
}

//MARK: - Private methods
private extension SwitchCell {
    
    func commonInit() {
        setupTypeLabelConstraints()
        setupTypeSwitchConstraints()
        setNewStatus()
    }
    
    private func setNewStatus() {
        typeSwitch.addTarget(self, action: #selector(changeStatus), for: .valueChanged)
    }
    
    @objc
    func changeStatus() {
        currentStatus = typeSwitch.isOn ? .completed : .planned
        delegate?.updateTaskStatus(self, currentStatus)
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
