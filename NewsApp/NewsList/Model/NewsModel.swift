//
//  NewModel.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 05.10.2020.
//

import Foundation

struct NewsModel {
    var title: String?
    var description: String?
    var date: String?
    var dateFormat: Date
    var isSee: Bool
    
    init(title: String?, description: String?, date: String?, isSee: Bool) {
        self.title = title
        self.description =  description
        self.isSee = isSee
        self.dateFormat = NewsModel.convertStringDateToDate(dateString: date ?? "")
        self.date = NewsModel.convertDateToPrettyString(date: dateFormat)
    }
    
    static func convertStringDateToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        guard let date = dateFormatter.date(from: dateString) else { return Date() }
        return date
    }
    
    static func convertDateToPrettyString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "MM.dd.yyyy hh:mm"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
