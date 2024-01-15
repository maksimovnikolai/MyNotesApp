//
//  EditViewPresenter.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 13.01.2024.
//

import Foundation

//MARK: - EditViewControllerProtocol
protocol EditViewControllerProtocol: AnyObject {
    func updateView()
}

//MARK: - EditPresenterProtocol
protocol EditPresenterProtocol: AnyObject {
    
    init(view: EditViewControllerProtocol, router: RouterProtocol)
    func setTaskText() -> String
    func setTypeText() -> String
    func showTypeView()
    func updateTaskType(_: TaskPriority)
}

//MARK: - Presenter
final class EditViewPresenter: EditPresenterProtocol {
 
    //MARK: Private properties
    private weak var view: EditViewControllerProtocol?
    private var router: RouterProtocol
    
    private var taskText: String = ""
    private var taskType: TaskPriority = .normal
    private var taskStatus: TaskStatus = .planned
    
    private var taskTitles: [TaskPriority: String] = [
        .important: "Важная",
        .normal: "Текущая"
    ]
    
    private var doAfterEdit: ((String, TaskPriority, TaskStatus) -> Void)?
    
    //MARK: Init
    init(view: EditViewControllerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        
    }
    
    //MARK: Public methods
    func setTaskText() -> String {
        taskText
    }
    
    func setTypeText() -> String {
        taskTitles[taskType] ?? ""
    }
    
    func showTypeView() {
        router.showTypeView(with: taskType)
    }
    
    func updateTaskType(_ taskType: TaskPriority) {
        self.taskType = taskType
        view?.updateView()
    }
}
