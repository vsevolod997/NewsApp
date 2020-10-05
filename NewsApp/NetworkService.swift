//
//  NetworkService.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 05.10.2020.
//

import Foundation

protocol NetworkServiceProtocol: class {
    func getData()
}

class NetworkService: NetworkServiceProtocol {
    func getData() {
        print("getData")
    }
}


