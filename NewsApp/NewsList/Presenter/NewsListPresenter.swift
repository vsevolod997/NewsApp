//
//  NewsListPresenter.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 05.10.2020.
//

import Foundation

protocol NewsListViewProtocol: class {
    func setData()
    func setError(mess: String)
}

protocol NewsListPresenterProtocol: class {
    var newsList: [NewsModel]? {get set}
    init(view: NewsListViewProtocol, network: NetworkServiceProtocol, router: RouterProtocol)
    
    func showView()
    func selectNew(news: NewsModel?)
}


class NewsListPresenter: NewsListPresenterProtocol {
    
    var newsList: [NewsModel]?
    
    weak var view: NewsListViewProtocol?
    var router: RouterProtocol?
    var networkService: NetworkServiceProtocol?
    
    required init(view: NewsListViewProtocol, network: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = network
        self.router = router
    }
    
    func showView() {
       // print(#func)
    }
    
    func selectNew(news: NewsModel?) {
        router?.showDetailNews(person: news)
    }
    
    
}
