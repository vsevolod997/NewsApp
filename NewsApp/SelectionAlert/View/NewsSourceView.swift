//
//  NewsSourceView.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 07.10.2020.
//

import UIKit

class NewsSourceView: UIButton {
    
    private var nameLabel: UILabel!
    private var icoImage: UIImageView!
    
    var value: NewsDataSourceModel! {
        didSet {
            setData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setIco()
        setTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setIco()
        setTitleLabel()
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                alpha = 0.6
                transform = .init(scaleX: 0.9, y: 0.9)
            } else {
                alpha = 1
                transform = .init(scaleX: 1, y: 1)
            }
        }
    }
    
    private func setData() {
        guard let name = value else { return }
        nameLabel.text = name.name
        let icoName = name.isSelect ? "checkmark.circle.fill" : "checkmark.circle"
        icoImage.image = UIImage(systemName: icoName)
    }
    
    private func setupView() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .secondarySystemBackground
    }
    
    private func setIco() {
        icoImage = UIImageView()
        icoImage.contentMode = .scaleAspectFill
        icoImage.tintColor = .systemGray
        icoImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(icoImage)
        
        icoImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        icoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icoImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        icoImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    private func setTitleLabel() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: icoImage.leftAnchor, constant: 8).isActive = true
    }
}
