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
    func saveButtonDidTap()
    func showAlert()
}

//MARK: - EditPresenterProtocol
protocol EditPresenterProtocol: AnyObject {
    var taskTitle: String { get set }
    var status: TaskStatus { get set }
    var taskTypeTitle: String { get }
    init(view: EditViewControllerProtocol, router: RouterProtocol)
    func showTypeView()
    func updateTaskType(_: TaskPriority)
    func popToMainview()
    func showAlert()
}

//MARK: - Presenter
final class EditViewPresenter: EditPresenterProtocol {
 
    
    
    //MARK: Public properties
    var taskTitle: String {
        get {
            taskText
        }
        
        set {
            taskText = newValue
        }
    }
    
    var taskTypeTitle: String {
        taskTitles[taskType] ?? ""
    }
    
    var status: TaskStatus {
        get {
            taskStatus
        }
        set {
            taskStatus = newValue
        }
    }
    
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
    
    //MARK: Init
    init(view: EditViewControllerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    //MARK: Privaete methods
    private func addNewTask() -> Task {
        let newTask = Task(title: taskTitle, type: taskType, status: taskStatus)
        return newTask
    }
    
    //MARK: Public methods
    func updateTaskType(_ taskType: TaskPriority) {
        self.taskType = taskType
        view?.updateView()
    }
    
    func showAlert() {
        view?.showAlert()
    }
    
    func showTypeView() {
        router.showTypeView(with: taskType)
    }
    
    func popToMainview() {
        router.popToMainView(task: addNewTask())
    }
}
