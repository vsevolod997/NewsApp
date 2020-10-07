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
    var viewStatus: NewsListStatus {get set}
    var newsList: [NewsModel]? {get set}
    init(view: NewsListViewProtocol, network: NetworkServiceProtocol, router: RouterProtocol)
    
    func loadNews()
    func selectNew(index: IndexPath)
    func showSetup()
}

enum LoadSource {
    case none
    case first
    case second
    case all
}

enum NewsListStatus {
    case loading
    case load
    case nodata
}

//MARK: - NewsListPresenterProtocol
class NewsListPresenter: NewsListPresenterProtocol {
    
    var viewStatus: NewsListStatus = .loading
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
        viewStatus = .loading
        newsList = []
        switch controlLoadSource() {
        case .all:
            loadAllData()
        case .first:
            let url = ActiveListDataSourceSingleton.selectedObject.firstDataSource.dataURL
            loadOneData(stringUrl: url)
        case .second:
            let url = ActiveListDataSourceSingleton.selectedObject.secondDataSource.dataURL
            loadOneData(stringUrl: url)
        case .none:
            viewStatus = .nodata
            view?.setData()
        }
    }
    
    func selectNew(index: IndexPath) {
        newsList?[index.row].isSee = true
        router?.showDetailNews(news: newsList?[index.row])
    }
    
    func showSetup() {
        router?.showSelectAction()
    }
    
    private func loadAllData() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        var url = ActiveListDataSourceSingleton.selectedObject.firstDataSource.dataURL
        networkService?.getData(stringUrl: url, complition: { [weak self] (news, error) in
            guard let self = self else { return }
            if let err = error {
                self.view?.setError(mess: err.localizedDescription)
            } else {
                guard let listNews = news else { return }
                self.newsList?.append(contentsOf: listNews)
                dispatchGroup.leave()
            }
        })
        
        dispatchGroup.enter()
        url = ActiveListDataSourceSingleton.selectedObject.secondDataSource.dataURL
        networkService?.getData(stringUrl: url, complition: { [weak self] (news, error) in
            guard let self = self else { return }
            if let err = error {
                self.view?.setError(mess: err.localizedDescription)
            } else {
                guard let listNews = news else { return }
                self.newsList?.append(contentsOf: listNews)
                dispatchGroup.leave()
            }
        })
        
        dispatchGroup.notify(queue: .main) {
            self.newsList = self.newsList?.sorted(by: { elem1, elem2 in elem1.dateFormat > elem2.dateFormat})
            self.viewStatus = .load
            self.view?.setData()
        }
    }
    
    private func loadOneData(stringUrl: String) {
        networkService?.getData(stringUrl: stringUrl, complition: { [weak self] (news, error) in
            guard let self = self else { return }
            if let err = error {
                self.view?.setError(mess: err.localizedDescription)
            } else {
                guard let listNews = news else { return }
                self.newsList = listNews
                self.newsList?.sort(by: { elem1, elem2 in elem1.dateFormat > elem2.dateFormat})
                self.viewStatus = .load
                self.view?.setData()
            }
        })
    }
    
    private func controlLoadSource() -> LoadSource {
        let firstLoad = ActiveListDataSourceSingleton.selectedObject.firstDataSource.isSelect
        let secondLoad = ActiveListDataSourceSingleton.selectedObject.secondDataSource.isSelect
        
        if firstLoad && secondLoad {
            return .all
        } else if firstLoad {
            return .first
        } else if secondLoad {
            return .second
        } else {
            return .none
        }
    }
    
}
