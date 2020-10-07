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
    private var statusIdentifier = "statusIdenty"
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    private func setupView() {
        let setupButton = UIBarButtonItem(title: "Источники", style: .done, target: self, action: #selector(showSelectionView))
        navigationItem.rightBarButtonItem = setupButton
        
        view.backgroundColor = .systemBackground
        self.title = "Новости"
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.refreshControl = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: listIdentifier)
        tableView.register(StatusTableViewCell.self, forCellReuseIdentifier: statusIdentifier)
        
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        presenter.loadNews()
    }
    
    @objc func showSelectionView() {
        presenter.showSetup()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch presenter.viewStatus {
        case .load:
            return presenter.newsList?.count ?? 0
        case .loading:
            return 1
        case .nodata:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch presenter.viewStatus {
        case .load:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: listIdentifier, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
            cell.news = presenter.newsList?[indexPath.row]
            return cell
        case .loading:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: statusIdentifier, for: indexPath) as? StatusTableViewCell else { return UITableViewCell() }
            cell.messString = "ожидайте, загрузка данных..."
            return cell
        case .nodata:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: statusIdentifier, for: indexPath) as? StatusTableViewCell else { return UITableViewCell() }
            cell.messString = "у вас не выбранно ни одного источника..."
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectNew(index: indexPath)
    }
}

//MARK: - NewsListViewProtocol
extension NewsListViewController: NewsListViewProtocol {
    
    func setData() {
        if presenter.viewStatus == .load {
            tableView.allowsSelection = true
            tableView.separatorStyle = .singleLine
        } else {
            tableView.allowsSelection = false
            tableView.separatorStyle = .none
        }
        tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func setError(mess: String) {
        let alert = UIAlertController(title: "Внимание", message: "Произошла ошибка: \(mess)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
