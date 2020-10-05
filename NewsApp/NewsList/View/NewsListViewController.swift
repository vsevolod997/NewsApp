//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 05.10.2020.
//

import UIKit

class NewsListViewController: UIViewController {
    
    private var tableView: UITableView!
    private var listIdentifier = "listIdenty"
    
    var presenter: NewsListPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: listIdentifier)
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listIdentifier, for: indexPath)
        cell.textLabel?.text = "test : \(indexPath)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectNew(news: NewsModel(title: "title", description: "description", date: "12.03.2020"))
    }
}


//MARK: - NewsListViewProtocol
extension NewsListViewController: NewsListViewProtocol {
    func setData() {
        print("data")
    }
    
    func setError(mess: String) {
        print("error: \(mess)")
    }
}
