//
//  EditViewPresenter.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 13.01.2024.
//

import Foundation

//MARK: - EditViewControllerProtocol
protocol EditViewControllerProtocol: AnyObject {
    
}

//MARK: - EditPresenterProtocol
protocol EditPresenterProtocol: AnyObject {
    
    init(view: EditViewControllerProtocol, router: RouterProtocol)
}

//MARK: - Presenter
final class EditViewPresenter: EditPresenterProtocol {
    
    private weak var view: EditViewControllerProtocol?
    private var router: RouterProtocol
    
    init(view: EditViewControllerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
}
