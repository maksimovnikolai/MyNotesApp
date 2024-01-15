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
        view.backgroundColor = .green
    }
}

//MARK: - TypeViewProtocol
extension TypeViewController: TypeViewProtocol {
    
}
