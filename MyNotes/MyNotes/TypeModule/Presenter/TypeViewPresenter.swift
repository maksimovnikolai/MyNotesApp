//
//  TypeViewPresenter.swift
//  MyNotes
//
//  Created by Nikolai Maksimov on 15.01.2024.
//

import Foundation

//MARK: - TypeViewProtocol
protocol TypeViewProtocol: AnyObject {}

//MARK: - TypeViewPresenterProtocol
protocol TypeViewPresenterProtocol: AnyObject {
    
    init(view: TypeViewProtocol, router: RouterProtocol, currentType: TaskPriority)
    func numberOfRowInSection() -> Int
    func configureCell(at: IndexPath) -> (title: String, description: String)
    func isSelected(at: IndexPath) -> Bool
    func popToEditView(_ indexPath: IndexPath)
}

//MARK: - Presenter
final class TypeViewPresenter: TypeViewPresenterProtocol {
  
    typealias TypeCellDescription = (type: TaskPriority, title: String, description: String)
    
    //MARK: Private porperties
    private weak var view: TypeViewProtocol?
    private var router: RouterProtocol
    
    private var doAfterTypeSelected: ((TaskPriority) -> Void)?
    private var selectedType: TaskPriority = .important
    
    private var taskTypeInformation: [TypeCellDescription] = [(
        type: .important, title: "Важная", description: """
    Такой тип задач является наиболее приоритетным для выполнения.
    Все важные задачи выводятся в
    самом верху списка задач.
    """),
        (type: .normal, title: "Текущая", description: "Задача с обычным приоритетом")
    ]
    
    //MARK: Init
    init(view: TypeViewProtocol, router: RouterProtocol, currentType: TaskPriority) {
        self.view = view
        self.router = router
        self.selectedType = currentType
    }
    
    //MARK: Public methods
    func numberOfRowInSection() -> Int {
        taskTypeInformation.count
    }
    
    func configureCell(at indexPath: IndexPath) -> (title: String, description: String) {
        let typeDescription = taskTypeInformation[indexPath.row]
        return (title: typeDescription.title, description: typeDescription.description)
    }
    
    func isSelected(at indexPath: IndexPath) -> Bool {
        let typeDescription = taskTypeInformation[indexPath.row]
        return selectedType == typeDescription.type ? true : false
    }
    
    func popToEditView(_ indexPath: IndexPath) {
        let selectedType = taskTypeInformation[indexPath.row].type
        router.popToEditView(selectedType)
    }
}
