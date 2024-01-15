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
}

//MARK: - TypeViewProtocol
extension TypeViewController: TypeViewProtocol {
    
}


//MARK: - Private methods
extension TypeViewController {
    
    private func commonInit() {
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(TypeViewCell.self, forCellReuseIdentifier: TypeViewCell.identifier)
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
