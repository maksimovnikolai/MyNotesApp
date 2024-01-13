//
//  AssemblyBuilder.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 12.01.2024.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createEditModule(router: RouterProtocol) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController(style: .insetGrouped)
        let storage = TasksStorage()
        let presenter = MainViewPresenter(view: view, router: router, storage: storage)
        view.presenter = presenter
        return view
    }
    
    func createEditModule(router: RouterProtocol) -> UIViewController {
        let view = EditViewController(style: .insetGrouped)
        let presenter = EditViewPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
