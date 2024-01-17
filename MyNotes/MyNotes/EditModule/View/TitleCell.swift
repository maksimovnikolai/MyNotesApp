//
//  TitleCell.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 14.01.2024.
//

import UIKit

protocol TitleCellDelegate: AnyObject {
    func getNewText(_ titleCell: TitleCell, _ text: String)
}

final class TitleCell: UITableViewCell {
    
    static let identifier = "TitleCell"
    
    //MARK: Private properties
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название заметки"
        textField.font = .systemFont(ofSize: 17)
        return textField
    }()
    
    weak var delegate: TitleCellDelegate!
    
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

//MARK: - UITextFieldDelegate
extension TitleCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        delegate.getNewText(self, text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - Private methods
private extension TitleCell {
    func commonInit() {
        titleTextField.delegate = self
        setupTextFieldConstraints()
    }
    
    func setupTextFieldConstraints() {
        contentView.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
