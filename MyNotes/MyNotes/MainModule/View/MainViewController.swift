//
//  MainViewController.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 12.01.2024.
//

import UIKit

final class MainViewController: UITableViewController {
    
    //MARK: Public properties
    var presenter: MainViewPresenterProtocol!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

//MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    
    func updateUI() {
        tableView.reloadData()
    }
    
    @objc
    func addButtonDidTap() {
        presenter.showEditScene()
    }
}

//MARK: - Private Methods
extension MainViewController {
    
    private func commonInit() {
        setupTableView()
        configureNavigationBar()
        setupBarButton()
    }
    
    private func setupTableView() {
        tableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
        tableView.rowHeight = 60
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Мои Заметки"
    }
    
    private func setupBarButton() {
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonDidTap))
    }
}

//MARK: - TableViewDataSource
extension MainViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowIn(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainViewCell.identifier,
            for: indexPath) as? MainViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(presenter.setCellTask(at: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.setupTitleForHeader(in: section)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        presenter.removeTask(at: indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        presenter.move(at: sourceIndexPath, to: destinationIndexPath)
        tableView.reloadData()
    }
}

//MARK: - TableViewDelegate
extension MainViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.changeTaskStatusForCompleted(indexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        } reload: {
            tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if presenter.isCompleted(indexPath) {
            let actionSwipeInstance = UIContextualAction(style: .normal, title: "Не выполнена") { [weak self] _, _, _ in
                self?.presenter.changeTaskStatusForPlanned(indexPath) {
                    tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
                }
            }
            return UISwipeActionsConfiguration(actions: [actionSwipeInstance])
        }
        return nil
    }
}
