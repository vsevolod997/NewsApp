//
//  Router.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 05.10.2020.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetailNews(news: NewsModel?)
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    func initialViewController() {
        if let navController = navigationController {
            guard let newsVC = builder?.showNewsListView(router: self) else { return }
            navController.viewControllers = [newsVC]
        }
    }
    
    func showDetailNews(news: NewsModel?) {
        if let navController = navigationController {
            guard let detailVC = builder?.showDetailView(news: news, router: self) else { return }
            navController.pushViewController(detailVC, animated: true)
        }
    }
    
    func popToRoot() {
        navigationController?.popViewController(animated: true)
    }
    
}
