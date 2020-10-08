//
//  Builder.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 05.10.2020.
//

import UIKit

protocol BuilderProtocol {
    func showNewsListView(router: RouterProtocol) -> UIViewController
    func showDetailView(news: NewsModel?, router: RouterProtocol) -> UIViewController
    func showSelectAction(router: RouterProtocol, rootVC: UIViewController) -> UIAlertController
}


class Builder: BuilderProtocol {
    
    func showNewsListView(router: RouterProtocol) -> UIViewController {
        let view = NewsListViewController()
        let parser = ParserService()
        let networkService = NetworkService()
        networkService.parseService = parser
        let presenter = NewsListPresenter(view: view, network: networkService, router: router)
        view.presenter = presenter
        
        return view
    }
    
    func showDetailView(news: NewsModel?, router: RouterProtocol) -> UIViewController {
        let view = DescriptionsViewController()
        let presnter = DescriptionViewPresenter(view: view, news: news, router: router)
        view.presenter = presnter
        
        return view
    }
    
    func showSelectAction(router: RouterProtocol, rootVC: UIViewController) -> UIAlertController {
        guard let newsListVC = rootVC as? NewsListViewController else { return UIAlertController() }
        let alertView = SelectDataSourceAlertController(title: nil, message: "Выберите источник данных", preferredStyle: .actionSheet)
        var value1 = ActiveListDataSourceSingleton.selectedObject.firstDataSource
        var value2 = ActiveListDataSourceSingleton.selectedObject.secondDataSource
        
        let alertPresenter = SelectDataSourceAlertPresenter(view: alertView, dataOne: value1, dataTwo: value2)
        alertView.presenter = alertPresenter
        
        alertPresenter.changedOne = { newFirstValue in
            value1 = newFirstValue
        }
        
        alertPresenter.changedTwo = { newSecondValue in
            value2 = newSecondValue
        }
        
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
        let actionReload = UIAlertAction(title: "Применить", style: .default) { action in
            
        ActiveListDataSourceSingleton.selectedObject.firstDataSource = value1
        ActiveListDataSourceSingleton.selectedObject.secondDataSource = value2
        
            newsListVC.presenter.loadNews()
        }
        
        alertView.addAction(actionCancel)
        alertView.addAction(actionReload)
        
        return alertView
    }
}
