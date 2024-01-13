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
    private lazy var symbolLabel = makeLabel(withTitle: "Left")
    private lazy var titleLabel = makeLabel(withTitle: "Rigth")
    
    
    //MARK: Initializer
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
        setupLeftLabelConstraints()
        setupRightLabelConstraints()
    }
    
    func makeLabel(withTitle title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.numberOfLines = 0
        return label
    }
    
    func getSymbolForTask(with status: TaskStatus) {
        symbolLabel.text = status == .planned ? "\u{25CB}" : "\u{25C9}"
    }
    
    func setupColorForLabels(with status: TaskStatus) {
        [titleLabel, symbolLabel].forEach {
            $0.textColor = status == .planned ? .black : .lightGray
        }
    }
}

//MARK: - Setup Constraints
extension MainViewCell {
    
    private func setupLeftLabelConstraints() {
        contentView.addSubview(symbolLabel)
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            symbolLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            symbolLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            symbolLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            symbolLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            symbolLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
        symbolLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupRightLabelConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
