//
//  TypeViewPresenter.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 15.01.2024.
//

import Foundation

//MARK: TypeViewProtocol
protocol TypeViewProtocol: AnyObject {
    
}

//MARK: TypeViewPresenterProtocol
protocol TypeViewPresenterProtocol: AnyObject {
    
    init(view: TypeViewProtocol)
}

//MARK: TypeViewPresenter
final class TypeViewPresenter: TypeViewPresenterProtocol {

    //MARK: Private porperties
    private var view: TypeViewProtocol?
    
    init(view: TypeViewProtocol) {
        self.view = view
    }

}
