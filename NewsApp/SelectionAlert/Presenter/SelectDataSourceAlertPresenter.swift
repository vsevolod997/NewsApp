//
//  SelectDataSourceAlertPresenter.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 08.10.2020.
//

import Foundation

protocol SelectDataSourceAlertControllerProtocol: class {
    func setData()
}

protocol SelectDataSourceAlertPresenterProtocol: class {
    init(view: SelectDataSourceAlertControllerProtocol, dataOne: NewsDataSourceModel, dataTwo: NewsDataSourceModel)
    func pressOne()
    func pressTwo()
    func getData()
    var dataOne: NewsDataSourceModel? {get set}
    var dataTwo: NewsDataSourceModel? {get set}
    var changedOne: ((NewsDataSourceModel) ->())? {get set}
    var changedTwo: ((NewsDataSourceModel) ->())? {get set}
}


class SelectDataSourceAlertPresenter: SelectDataSourceAlertPresenterProtocol {
    
    weak var view: SelectDataSourceAlertControllerProtocol?
    var dataOne: NewsDataSourceModel?
    var dataTwo: NewsDataSourceModel?
    
    var changedOne: ((NewsDataSourceModel) -> ())?
    var changedTwo: ((NewsDataSourceModel) -> ())?
    
    required init(view: SelectDataSourceAlertControllerProtocol, dataOne: NewsDataSourceModel, dataTwo: NewsDataSourceModel) {
        self.view = view
        self.dataOne = dataOne
        self.dataTwo = dataTwo
    }
    
    func getData() {
        view?.setData()
    }
    
    func pressOne() {
        guard let stateone = dataOne?.isSelect else { return }
        dataOne?.isSelect = !stateone
        changedOne?(dataOne!)
        view?.setData()
    }
    
    func pressTwo() {
        guard let statetwo = dataTwo?.isSelect else { return }
        dataTwo?.isSelect = !statetwo
        changedTwo?(dataTwo!)
        view?.setData()
    }
    
}
