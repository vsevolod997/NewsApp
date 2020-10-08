//
//  SelectDataSourceController.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 07.10.2020.
//

import UIKit

class SelectDataSourceAlertController: UIAlertController {

    private var optionOne: NewsSourceView!
    private var optionTwo: NewsSourceView!
    private var background: UIView!
    
    var presenter: SelectDataSourceAlertPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.getData()
    }
    
    private func setupView() {
        setupBackgrounView()
        setupOptionOne()
        setupOptionTwo()
    }
    
    fileprivate func setupBackgrounView() {
        background = UIView()
        background.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(background)
        
        background.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant: 8).isActive = true
        background.rightAnchor.constraint(equalTo: self.view.rightAnchor , constant: -8).isActive = true
        background.topAnchor.constraint(equalTo: self.view.topAnchor , constant: 30).isActive = true
        background.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.heightAnchor.constraint(equalToConstant: 330).isActive = true
    }
    
    fileprivate func setupOptionOne() {
        optionOne = NewsSourceView()
        optionOne.translatesAutoresizingMaskIntoConstraints = false
        optionOne.addTarget(self, action: #selector(pressFirst), for: .touchUpInside)
        view.addSubview(optionOne)
        
        optionOne.leftAnchor.constraint(equalTo: background.leftAnchor).isActive = true
        optionOne.rightAnchor.constraint(equalTo: background.rightAnchor).isActive = true
        optionOne.topAnchor.constraint(equalTo: background.topAnchor).isActive = true
        optionOne.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    fileprivate func setupOptionTwo() {
        optionTwo = NewsSourceView()
        optionTwo.translatesAutoresizingMaskIntoConstraints = false
        optionTwo.addTarget(self, action: #selector(pressSecond), for: .touchUpInside)
        view.addSubview(optionTwo)
        
        optionTwo.leftAnchor.constraint(equalTo: background.leftAnchor).isActive = true
        optionTwo.rightAnchor.constraint(equalTo: background.rightAnchor).isActive = true
        optionTwo.bottomAnchor.constraint(equalTo: background.bottomAnchor).isActive = true
        optionTwo.heightAnchor.constraint(equalToConstant: 80 ).isActive = true
    }
    
    @objc func pressSecond() {
        presenter.pressTwo()
    }
    
    @objc func pressFirst() {
        presenter.pressOne()
    }
}

extension SelectDataSourceAlertController: SelectDataSourceAlertControllerProtocol {
    
    func setData() {
        optionOne.value = presenter.dataOne
        optionTwo.value = presenter.dataTwo
    }
}
