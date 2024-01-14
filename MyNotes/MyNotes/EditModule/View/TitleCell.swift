//
//  TitleCell.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 14.01.2024.
//

import UIKit

final class TitleCell: UITableViewCell {
    
    static let identifier = "TitleCell"
    
    //MARK: Private properties
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите задачу"
        textField.font = .systemFont(ofSize: 17)
        return textField
    }()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public method
    func configure(_ taskTitle: String) {
        titleTextField.text = taskTitle
    }
}

//MARK: Private methods
private extension TitleCell {
    
    func commonInit() {
        setupTextFieldConstraints()
    }
    
    func setupTextFieldConstraints() {
        contentView.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
        ])
    }
}
