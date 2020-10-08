//
//  ActiveListDataSource.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 07.10.2020.
//

import Foundation


class ActiveListDataSourceSingleton {
    
    public var firstDataSource: NewsDataSourceModel = NewsDataSourceModel(name: "Финами.ру", isSelect: true, dataURL: "https://www.finam.ru/net/analysis/conews/rsspoint")
    public var secondDataSource: NewsDataSourceModel = NewsDataSourceModel(name: "Банки.ру", isSelect: true, dataURL: "https://www.banki.ru/xml/news.rss")
    
    static let selectedObject = ActiveListDataSourceSingleton()
    
    private init() {}
}
