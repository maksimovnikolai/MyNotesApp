//
//  EditViewController.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 13.01.2024.
//

import UIKit

final class EditViewController: UITableViewController {
    
    //MARK: Public properties
    var presenter: EditPresenterProtocol!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

//MARK: - EditViewControllerProtocol
extension EditViewController: EditViewControllerProtocol {
    
    func updateView() {
        tableView.reloadData()
    }
}

//MARK: - Private methods
private extension EditViewController {
    
    func commonInit() {
        registerTableViewCell()
    }
    
    private func registerTableViewCell() {
        tableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
        tableView.register(TypeCell.self, forCellReuseIdentifier: TypeCell.identifier)
        tableView.register(SwitchCell.self, forCellReuseIdentifier: SwitchCell.identifier)
    }
}

//MARK: - TableViewDataSource
extension EditViewController {
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Временная реализация
        var returnedCell = UITableViewCell()
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath) as? TitleCell else { return returnedCell }
            cell.configure(presenter.setTaskText())
            returnedCell = cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TypeCell.identifier, for: indexPath) as? TypeCell else { return returnedCell }
            cell.configure(presenter.setTypeText())
            returnedCell = cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier, for: indexPath) as? SwitchCell else { return returnedCell }
            cell.configure(presenter.isOn())
            returnedCell = cell
        }
        return returnedCell
    }
}

//MARK: - TableViewDelegate
extension EditViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            presenter.showTypeView()
        }
    }
}
