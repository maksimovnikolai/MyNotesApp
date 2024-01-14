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
    
}

//MARK: - Private methods
private extension EditViewController {
    
    func commonInit() {
        registerTableViewCell()
    }
    
    private func registerTableViewCell() {
        tableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
        tableView.register(TypeCell.self, forCellReuseIdentifier: TypeCell.identifier)
    }
    
    private func setup(identifier: String, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell
    }
}

//MARK: - TableViewDataSource
extension EditViewController {
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell = setup(identifier: TitleCell.identifier, indexPath: indexPath)
        case 1:
            cell = setup(identifier: TypeCell.identifier, indexPath: indexPath)
        default:
            break
        }
        return cell
    }
}
