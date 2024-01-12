//
//  MainViewPresenter.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 12.01.2024.
//

import Foundation

//MARK: - MainViewProtocol
protocol MainViewProtocol: AnyObject {
    
}

//MARK: - MainViewPresenterProtocol
protocol MainViewPresenterProtocol: AnyObject {
    
    init(view: MainViewProtocol)
}

//MARK: - Class MainViewPresenter
final class MainViewPresenter: MainViewPresenterProtocol {
    
    private weak var view: MainViewProtocol?
    
    init(view: MainViewProtocol) {
        self.view = view
    }
}

