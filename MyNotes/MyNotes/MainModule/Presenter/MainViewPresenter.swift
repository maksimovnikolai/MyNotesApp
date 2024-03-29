//
//  MainViewPresenter.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 12.01.2024.
//

import Foundation

//MARK: - MainViewProtocol
protocol MainViewProtocol: AnyObject {
    func addButtonDidTap()
    func updateUI()
}

//MARK: - MainViewPresenterProtocol
protocol MainViewPresenterProtocol: AnyObject {
    
    init(view: MainViewProtocol, router: RouterProtocol, storage: TasksStorageProtocol)
    func numberOfSections() -> Int
    func numberOfRowIn(_ section: Int) -> Int
    func setCellTask(at indexPath: IndexPath) -> TaskProtocol?
    func setupTitleForHeader(in section: Int) -> String
    func changeTaskStatusForCompleted(_ indexPath: IndexPath, deselect: () -> Void, reload: () -> Void)
    func isCompleted(_ indexPath: IndexPath) -> Bool
    func changeTaskStatusForPlanned(_ indexPath: IndexPath, action: () -> Void)
    func removeTask(at: IndexPath)
    func move(at source: IndexPath, to destination: IndexPath)
    func showEditScene()
    func updateTasks(_ newTask: Task)
}

//MARK: - Presenter
final class MainViewPresenter: MainViewPresenterProtocol {
    
    //MARK: Private properties
    private weak var view: MainViewProtocol?
    private var router: RouterProtocol
    private var storage: TasksStorageProtocol
    
    private var tasks: [TaskPriority : [TaskProtocol]] = [:] {
        didSet {
            for (taskGroupPriority, taskGroup) in tasks {
                tasks[taskGroupPriority] = taskGroup.sorted{ task1, task2 in
                    let task1position = tasksStatusPosition.firstIndex(of: task1.status) ?? 0
                    let task2position = tasksStatusPosition.firstIndex(of: task2.status) ?? 0
                    return task1position < task2position
                }
            }
        }
    }
    private var sectionsTypePosition: [TaskPriority] = [.important, .normal]
    private var tasksStatusPosition: [TaskStatus] = [.planned, .completed]
    
    //MARK: Init
    init(view: MainViewProtocol, router: RouterProtocol, storage: TasksStorageProtocol) {
        self.view = view
        self.router = router
        self.storage = storage
        loadTasks()
    }
    
    //MARK: Public Methods
    func loadTasks() {
        sectionsTypePosition.forEach {
            tasks[$0] = []
        }
        // загрузка и разбор задач из хранилища
        storage.loadTasks().forEach {
            tasks[$0.type]?.append($0)
        }
    }
    
    func numberOfSections() -> Int {
        tasks.count
    }
    
    func numberOfRowIn(_ section: Int) -> Int {
        let taskType = sectionsTypePosition[section]
        guard let currentTaskType = tasks[taskType] else { return 0 }
        return currentTaskType.count
    }
    
    func setCellTask(at indexPath: IndexPath) -> TaskProtocol? {
        let taskType = sectionsTypePosition[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else {
            return nil
        }
        return currentTask
    }
    
    func setupTitleForHeader(in section: Int) -> String {
        sectionsTypePosition[section] == .important ? "Важные" : "Текущие"
    }
    
    func changeTaskStatusForCompleted(_ indexPath: IndexPath, deselect: () -> Void, reload: () -> Void) {
       
        let taskType = sectionsTypePosition[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else {
            return
        }
        
        guard tasks[taskType]![indexPath.row].status == .planned else {
            deselect()
            return
        }
        tasks[taskType]![indexPath.row].status = .completed
        reload()
    }
    
    func isCompleted(_ indexPath: IndexPath) -> Bool {
        let taskType = sectionsTypePosition[indexPath.section]
        return tasks[taskType]![indexPath.row].status ==  .planned ? false : true
    }
    
    func changeTaskStatusForPlanned(_ indexPath: IndexPath, action: () -> Void) {
        let taskType = sectionsTypePosition[indexPath.section]
        guard let _ = tasks[taskType]?[indexPath.row] else { return }
    
        tasks[taskType]![indexPath.row].status = .planned
        action()
    }
    
    func removeTask(at indexPath: IndexPath) {
        let taskType = sectionsTypePosition[indexPath.section]
        tasks[taskType]?.remove(at: indexPath.row)
    }
    
    func move(at source: IndexPath, to destination: IndexPath) {
        let taskTypeFrom = sectionsTypePosition[source.section]
        let taskTypeTo = sectionsTypePosition[destination.section]
        guard let movedTask = tasks[taskTypeFrom]?[source.row] else {
            return
        }
        tasks[taskTypeFrom]?.remove(at: source.row)
        tasks[taskTypeTo]?.insert(movedTask, at: destination.row)
        if taskTypeFrom != taskTypeTo {
            tasks[taskTypeTo]?[destination.row].type = taskTypeTo
        }
    }
    
    func showEditScene() {
        router.showEditView()
    }
    
    func updateTasks(_ newTask: Task) {
        tasks[newTask.type]?.append(newTask)
        view?.updateUI()
    }
}
