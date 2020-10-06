//
//  ParserService.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 06.10.2020.
//

import Foundation

protocol ParserServiceProtocol: class {
    var callback: (([NewsModel]?) ->())? {get set}
    func parseXMLtoString(xmlData: Data)
}

class ParserService: NSObject, ParserServiceProtocol {
    
    var callback: (([NewsModel]?) -> ())?
    
    private var foundString = ""
    private var title = ""
    private var date = ""
    private var desc: String?  = ""
    private var newsList: [NewsModel] = []
    
    
    func parseXMLtoString(xmlData: Data) {
        let parser = XMLParser(data: xmlData)
        parser.delegate = self
        parser.parse()
        parser.shouldResolveExternalEntities = true
    }
    
    private func removeTagFromString(inputString: String) -> String? {
        guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: "<.*?>", options: .caseInsensitive) else { return nil }
        let range = NSMakeRange(0, foundString.count)
        let htmlLessString = regex.stringByReplacingMatches(in: foundString, options: .withoutAnchoringBounds, range:range , withTemplate: "")
        return htmlLessString
    }
}

//MARK: - XMLParserDelegate
extension ParserService: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "title" || elementName == "description" || elementName == "pubDate" {
            foundString = ""
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "title":
            title = foundString
        case "description":
            desc = removeTagFromString(inputString: foundString)
        case "pubDate":
            date = foundString
        case "item":
            let news = NewsModel(title: title, description: desc, date: date, isVisible: false)
            newsList.append(news)
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        foundString += string
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        callback?(newsList)
    }
}
