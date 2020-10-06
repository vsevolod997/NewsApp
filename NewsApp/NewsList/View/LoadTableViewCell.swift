//
//  LoadTableViewCell.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 05.10.2020.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    
    private var label: UILabel!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configureCell()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        //configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureCell() {
        label = UILabel()
        label.text = "ожидайте, идет загрузка..."
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 1).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 1).isActive = true
    }

}
