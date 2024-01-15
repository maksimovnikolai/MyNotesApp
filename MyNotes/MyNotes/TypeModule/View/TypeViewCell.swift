//
//  TypeViewCell.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 15.01.2024.
//

import UIKit

final class TypeViewCell: UITableViewCell {
    
    static let identifier = "TypeViewCell"
    
    //MARK: Private properties
    private lazy var typeTitleLAbel = makeLabel(withTitle: "Название типа", size: 17)
    private lazy var descriptionLabel = makeLabel(withTitle: "Описание типа", textColor: .systemGray, size: 13)
    private lazy var verticalStackView = UIStackView()
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public method
    func setTitle(typeTitle: String, descriptionTitle: String) {
        typeTitleLAbel.text = typeTitle
        descriptionLabel.text = descriptionTitle
    }
}

//MARK: Private methods
private extension TypeViewCell {
    
    func commonInit() {
        setupStackView()
        setupVerticalStackViewConstraints()
    }
    
    func makeLabel(withTitle title: String, textColor: UIColor? = .black, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = textColor
        label.font = .systemFont(ofSize: size)
        return label
    }
    
    func setupStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .fillEqually
        verticalStackView.addArrangedSubview(typeTitleLAbel)
        verticalStackView.addArrangedSubview(descriptionLabel)
    }
    
    func setupVerticalStackViewConstraints() {
        addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
        ])
    }
}
