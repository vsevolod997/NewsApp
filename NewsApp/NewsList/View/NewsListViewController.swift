//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 05.10.2020.
//

import UIKit

class NewsListViewController: UIViewController {
    var presenter: NewsListPresenterProtocol!

    private var tableView: UITableView!
    private var listIdentifier = "listIdenty"
    private var loadIdentifier = "loadIdenty"
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        
        presenter.loadNews()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        self.title = "Новости"
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.refreshControl = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: listIdentifier)
        tableView.register(StatusTableViewCell.self, forCellReuseIdentifier: loadIdentifier)
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        presenter.loadNews()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: listIdentifier, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        cell.news = presenter.newsList?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectNew(index: indexPath)
    }
}

//MARK: - NewsListViewProtocol
extension NewsListViewController: NewsListViewProtocol {
    
    func setData() {
        tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func setError(mess: String) {
        print("error: \(mess)")
    }
}
