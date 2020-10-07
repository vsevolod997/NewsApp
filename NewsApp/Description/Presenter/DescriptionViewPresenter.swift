//
//  DescriptionViewPresenter.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 05.10.2020.
//

import Foundation

protocol DescriptionViewProtocol: class {
    func setData(data: NewsModel)
}

protocol DescriptionViewPresenterProtocol: class {
    init(view: DescriptionViewProtocol, news: NewsModel?, router:RouterProtocol)
    func showNewsDescription()
    func backToList()
}

class DescriptionViewPresenter: DescriptionViewPresenterProtocol {
    
    weak var view: DescriptionViewProtocol?
    var router: RouterProtocol?
    var news: NewsModel?
    
    required init(view: DescriptionViewProtocol, news: NewsModel?, router: RouterProtocol) {
        self.news = news
        self.router = router
        self.view = view
    }
    
    func showNewsDescription() {
        view?.setData(data: news ?? NewsModel(title: "Не удалось отобразить новость", description: nil, date: nil, isSee: true))
    }
    
    func backToList() {
        router?.popToRoot()
    }
    
}
