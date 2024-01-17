//
//  MainViewCell.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 12.01.2024.
//

import UIKit

final class MainViewCell: UITableViewCell {
    
    static let identifier = "MainViewCell"
    
    //MARK: Private properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var symbolImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
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
    func configure(_ task: TaskProtocol?) {
        guard let task else { return }
        titleLabel.text = task.title
        getSymbolForTask(with: task.status)
        setupColorForLabels(with: task.status)
    }
}

//MARK: - Private Methods
private extension MainViewCell {
    
    func commonInit() {
        setupImageConstraints()
        setupLabelConstraints()
    }
    
    func getSymbolForTask(with status: TaskStatus) {
        symbolImage.image = status == .planned ? UIImage(systemName: "circle") : UIImage(systemName: "checkmark.circle")
    }
    
    func setupColorForLabels(with status: TaskStatus) {
        titleLabel.textColor = status == .planned ? .black : .lightGray
    }
}

//MARK: - Setup Constraints
extension MainViewCell {
    
    private func setupImageConstraints() {
        contentView.addSubview(symbolImage)
        symbolImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            symbolImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            symbolImage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            symbolImage.heightAnchor.constraint(equalToConstant: 20),
            symbolImage.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    private func setupLabelConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImage.trailingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
