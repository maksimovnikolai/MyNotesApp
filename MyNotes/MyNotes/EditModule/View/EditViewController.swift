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
    func showAlert() {
        let alert = UIAlertController(title: "Введите название заметки", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        
        alert.addAction(action)
        present(alert, animated: true)
    }

    func makeSaveBurButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonDidTap))
    }
    
    @objc
    func saveButtonDidTap() {
        view.endEditing(true)
        presenter.taskTitle == "" ? presenter.showAlert() : presenter.popToMainview()
    }
    
    func updateView() {
        tableView.reloadData()
    }
}

//MARK: - TitleCellDelegate
extension EditViewController: TitleCellDelegate {
    
    func getNewText(_ titleCell: TitleCell, _ text: String) {
        presenter.taskTitle =  text
    }
}

//MARK: - SwitchCellDelegate
extension EditViewController: SwitchCellDelegate {
    func updateTaskStatus(_ switchCell: SwitchCell, _ status: TaskStatus) {
        presenter.status = status
    }
}

//MARK: - Private methods
private extension EditViewController {
    func commonInit() {
        registerTableViewCell()
        makeSaveBurButton()
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationItem.title = "Новая заметка"
        navigationController?.navigationBar.topItem?.backButtonTitle = "Назад"
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
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath) as? TitleCell else { return UITableViewCell() }
            cell.configure(presenter.taskTitle)
            cell.delegate = self
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TypeCell.identifier, for: indexPath) as? TypeCell else { return UITableViewCell() }
            cell.configure(presenter.taskTypeTitle)
            return cell
            
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier, for: indexPath) as? SwitchCell else { return UITableViewCell() }
            cell.configure(with: presenter.status)
            cell.delegate = self
            return cell
        }
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
