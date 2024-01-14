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
    func setTaskText() -> String
    func setTypeText() -> String
}

//MARK: - Presenter
final class EditViewPresenter: EditPresenterProtocol {
 
    private weak var view: EditViewControllerProtocol?
    private var router: RouterProtocol
    
    // параметры задачи
    private var taskText: String = ""
    private var taskType: TaskPriority = .normal
    private var taskStatus: TaskStatus = .planned
    
    private var taskTitles: [TaskPriority: String] = [
        .important: "Важная",
        .normal: "Текущая"
    ]
    
    private var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    
    init(view: EditViewControllerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func setTaskText() -> String {
        taskText
    }
    
    func setTypeText() -> String {
        taskTitles[taskType] ?? ""
    }
    
}
