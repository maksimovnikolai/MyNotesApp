//
//  AssemblyBuilder.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 12.01.2024.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController(style: .insetGrouped)
        let storage = TasksStorage()
        let presenter = MainViewPresenter(view: view, router: router, storage: storage)
        view.presenter = presenter
        return view
    }
}
