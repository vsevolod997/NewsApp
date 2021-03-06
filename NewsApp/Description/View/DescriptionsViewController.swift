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
    private var descriptionTextView: UITextView!
    private var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTitleLabel()
        setDateLabel()
        setTextView()
        
        presenter.showNewsDescription()
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Детальная Информация"
    }
    
    private func setTitleLabel() {
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 21)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor , constant: 0 ).isActive = true
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
        descriptionTextView = UITextView()
        descriptionTextView.font = UIFont.italicSystemFont(ofSize: 14)
        descriptionTextView.textAlignment = .justified
        descriptionTextView.isEditable = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(descriptionTextView)
        
        descriptionTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 3).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
}

//MARK: - DescriptionViewProtocol
extension DescriptionsViewController: DescriptionViewProtocol {
    
    func setData(data: NewsModel) {
        titleLabel.text = data.title
        dateLabel.text = data.date
        descriptionTextView.text = data.description
    }
}
