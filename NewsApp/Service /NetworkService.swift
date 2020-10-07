//
//  NetworkService.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 05.10.2020.
//

import Foundation

protocol NetworkServiceProtocol: class {
    func getData(stringUrl: String, complition: @escaping([NewsModel]?, Error?)->())
}

class NetworkService: NSObject, NetworkServiceProtocol {
    
    var parseService: ParserServiceProtocol?

    func getData(stringUrl: String, complition: @escaping ([NewsModel]?, Error?) -> ()) {
        self.parseService?.callback = { result in
            complition(result, nil)
        }
        guard let url = URL(string: stringUrl) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let err = error {
                DispatchQueue.main.async {
                    complition(nil, err)
                }
            } else {
                DispatchQueue.main.async {
                    guard let xmlData = data else { return }
                    self.parseService?.parseXMLtoString(xmlData: xmlData)
                }
            }
            
        }
        task.resume()
    }
}
