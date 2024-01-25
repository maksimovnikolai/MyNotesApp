//
//  TypeViewController.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 15.01.2024.
//

import UIKit

final class TypeViewController: UITableViewController {
    
    //MARK: Public properties
    var presenter: TypeViewPresenterProtocol!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        registerTableViewCell()
        configureNavBar()
    }
}

//MARK: - TypeViewProtocol
extension TypeViewController: TypeViewProtocol {
    func registerTableViewCell() {
        tableView.register(TypeViewCell.self, forCellReuseIdentifier: TypeViewCell.identifier)
    }
    
    func configureNavBar() {
        navigationItem.title = "Статус"
        navigationController?.navigationBar.topItem?.backButtonTitle = "Назад"
    }
}

//MARK: - TableViewDataSource
extension TypeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TypeViewCell.identifier, for: indexPath) as? TypeViewCell else {
            return UITableViewCell()
        }
        cell.setTitle(with: presenter.configureCell(at: indexPath))
        
        if presenter.isSelected(at: indexPath) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

//MARK: - TableViewDelegate
extension TypeViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.popToEditView(indexPath)
    }
}
