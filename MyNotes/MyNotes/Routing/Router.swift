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
    func showTypeView(with: TaskPriority)
    func popToEditView(_ taskPriority: TaskPriority)
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
    
    func showTypeView(with priority: TaskPriority) {
        if let navigationController = navigationController {
            guard let typeController = assemblyBuilder?.createTypeModule(taskPriority: priority, router: self) else { return }
            navigationController.pushViewController(typeController, animated: true)
        }
    }
    
    func popToEditView(_ taskPriority: TaskPriority) {
        navigationController?.viewControllers.forEach { viewController in
            if let viewController = viewController as? EditViewController {
                viewController.presenter.updateTaskType(taskPriority)
                navigationController?.popToViewController(viewController, animated: true)
            }
        }
    }
}
