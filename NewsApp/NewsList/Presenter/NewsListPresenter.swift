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
    
    func loadNews()
    func selectNew(index: IndexPath)
}

//MARK: - NewsListPresenterProtocol
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
    
    func loadNews() {
        networkService?.getData(stringUrl: "https://www.banki.ru/xml/news.rss", complition: { [weak self] (news, error) in
            guard let self = self else { return }
            if let err = error {
                self.view?.setError(mess: err.localizedDescription)
            } else {
                guard let listNews = news else { return }
                self.newsList = listNews
                self.view?.setData()
            }
        })
    }
    
    func selectNew(index: IndexPath) {
        router?.showDetailNews(news: newsList?[index.row])
    }
}
