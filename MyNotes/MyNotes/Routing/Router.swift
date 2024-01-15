//
//  Router.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 12.01.2024.
//

import UIKit

protocol RouterMainProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMainProtocol {
    func initialViewController()
    func showEditView()
    func showTypeView()
}

final class Router: RouterProtocol {

    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showEditView() {
        if let navigationController = navigationController {
            guard let editController = assemblyBuilder?.createEditModule(router: self) else { return }
            navigationController.pushViewController(editController, animated: true)
        }
    }
    
    func showTypeView() {
        if let navigationController = navigationController {
            guard let typeController = assemblyBuilder?.createTypeModule(router: self) else { return }
            navigationController.pushViewController(typeController, animated: true)
        }
    }
}
