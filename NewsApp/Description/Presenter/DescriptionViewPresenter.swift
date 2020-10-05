//
//  DescriptionViewPresenter.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 05.10.2020.
//

import Foundation

protocol DescriptionViewProtocol: class {
    func setData(data: NewsModel?)
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
        self.router = router
    }
    
    func showNewsDescription() {
        print(news)
    }
    
    func backToList() {
        router?.popToRoot()
    }
    
}
