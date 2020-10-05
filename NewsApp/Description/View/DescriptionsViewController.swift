//
//  DescriptionsViewController.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 05.10.2020.
//

import UIKit

class DescriptionsViewController: UIViewController {

    var presenter: DescriptionViewPresenterProtocol!
    
    private var titleLabel: UILabel!
    private var textView: UITextView!
    private var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setTitleLabel()
        setDateLabel()
        setTextView()
    }
    
    func setupView() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Детальная Информация"
    }
    
    private func setTitleLabel() {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 21)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.view.topAnchor, multiplier: 9).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
    }
    
    private func setDateLabel() {
        dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 12, weight: .light)
        dateLabel.tintColor = .secondarySystemBackground
        dateLabel.textAlignment = .right
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dateLabel)
        
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
    }
    
    private func setTextView() {
        textView = UITextView()
        textView.font = UIFont.italicSystemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textView)
        
        textView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 3).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8).isActive = true
    }
}

extension DescriptionsViewController: DescriptionViewProtocol {
    func setData(data: NewsModel?) {
        print(data)
    }
}
