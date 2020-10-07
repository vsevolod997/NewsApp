//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 06.10.2020.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    
    public var news: NewsModel! {
        didSet {
            setupTitleLabel()
            setupDateLabel()
            setData()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = .systemBackground
        titleLabel.removeFromSuperview()
        dateLabel.removeFromSuperview()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setData() {
        guard let news = self.news else { return }
        if news.isSee {
            backgroundColor = .lightGray
        }
        titleLabel.text = news.title
        dateLabel.text = news.date
    }
    
    private func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = ""
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
        
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
    }
    
    private func setupDateLabel() {
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = ""
        dateLabel.font = .systemFont(ofSize: 9, weight: .regular)
        dateLabel.numberOfLines = 0
        dateLabel.textAlignment = .right
        addSubview(dateLabel)
        
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
}
