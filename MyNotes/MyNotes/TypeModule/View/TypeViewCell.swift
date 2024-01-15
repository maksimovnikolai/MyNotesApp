//
//  TypeViewCell.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 15.01.2024.
//

import UIKit

final class TypeViewCell: UITableViewCell {
    
    //MARK: Identifier
    static let identifier = "TypeViewCell"
    
    //MARK: Private properties
    private lazy var typeTitleLAbel = makeLabel(withTitle: "Название типа", size: 17)
    private lazy var descriptionLabel = makeLabel(withTitle: "Описание типа", textColor: .systemGray, size: 13)
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public method
    func setTitle(with value: (title: String, description: String)) {
        typeTitleLAbel.text = value.title
        descriptionLabel.text = value.description
    }
}

//MARK: Private methods
private extension TypeViewCell {
    
    func commonInit() {
        setupTypeTitleLAbelConstraints()
        setupDescriptionLabelConstraints()
    }
    
    func makeLabel(withTitle title: String, textColor: UIColor? = .black, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = title
        label.textColor = textColor
        label.font = .systemFont(ofSize: size)
        return label
    }
    
    func setupTypeTitleLAbelConstraints() {
        contentView.addSubview(typeTitleLAbel)
        typeTitleLAbel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeTitleLAbel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            typeTitleLAbel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            typeTitleLAbel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    func setupDescriptionLabelConstraints() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: typeTitleLAbel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: typeTitleLAbel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: typeTitleLAbel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
