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
}
