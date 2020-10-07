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
        let alert = SelectDataSourceAlertController(title: nil, message: "Выберите источник данных", preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
        let actionReload = UIAlertAction(title: "Применить", style: .default) { action in
            newsListVC.presenter.loadNews()
        }
        
        alert.addAction(actionCancel)
        alert.addAction(actionReload)
        
        return alert
    }
}
