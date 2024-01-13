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
        view.backgroundColor = .cyan
    }
}

//MARK: - EditViewControllerProtocol
extension EditViewController: EditViewControllerProtocol {
    
}
