//
//  AssemblyBuilder.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 12.01.2024.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule() -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let presenter = MainViewPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
