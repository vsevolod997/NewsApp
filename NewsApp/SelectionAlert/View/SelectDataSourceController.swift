//
//  SelectDataSourceController.swift
//  NewsApp
//
//  Created by Всеволод Андрющенко on 07.10.2020.
//

import UIKit

class SelectDataSourceAlertController: UIAlertController {

    var optionOne: NewsSourceView!
    var optionTwo: NewsSourceView!
    var bacgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupBackgrounView()
        setupOptionOne()
        setupOptionTwo()
    }
    
    fileprivate func setupBackgrounView() {
        bacgroundView = UIView()
        bacgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bacgroundView)
        
        bacgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor , constant: 8).isActive = true
        bacgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor , constant: -8).isActive = true
        bacgroundView.topAnchor.constraint(equalTo: self.view.topAnchor , constant: 30).isActive = true
        bacgroundView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.heightAnchor.constraint(equalToConstant: 330).isActive = true
    }
    
    fileprivate func setupOptionOne() {
        optionOne = NewsSourceView()
        optionOne.translatesAutoresizingMaskIntoConstraints = false
        optionOne.value = ActiveListDataSourceSingleton.selectedObject.firstDataSource
        optionOne.addTarget(self, action: #selector(pressFirst), for: .touchUpInside)
        view.addSubview(optionOne)
        
        optionOne.leftAnchor.constraint(equalTo: bacgroundView.leftAnchor).isActive = true
        optionOne.rightAnchor.constraint(equalTo: bacgroundView.rightAnchor).isActive = true
        optionOne.topAnchor.constraint(equalTo: bacgroundView.topAnchor).isActive = true
        optionOne.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    fileprivate func setupOptionTwo() {
        optionTwo = NewsSourceView()
        optionTwo.translatesAutoresizingMaskIntoConstraints = false
        optionTwo.value = ActiveListDataSourceSingleton.selectedObject.secondDataSource
        optionTwo.addTarget(self, action: #selector(pressSecond), for: .touchUpInside)
        view.addSubview(optionTwo)
        
        optionTwo.leftAnchor.constraint(equalTo: bacgroundView.leftAnchor).isActive = true
        optionTwo.rightAnchor.constraint(equalTo: bacgroundView.rightAnchor).isActive = true
        optionTwo.bottomAnchor.constraint(equalTo: bacgroundView.bottomAnchor).isActive = true
        optionTwo.heightAnchor.constraint(equalToConstant: 80 ).isActive = true
    }
    
    @objc func pressSecond() {
        ActiveListDataSourceSingleton.selectedObject.secondDataSource.isSelect = !ActiveListDataSourceSingleton.selectedObject.secondDataSource.isSelect
        optionTwo.value = ActiveListDataSourceSingleton.selectedObject.secondDataSource
    }
    
    @objc func pressFirst() {
        ActiveListDataSourceSingleton.selectedObject.firstDataSource.isSelect = !ActiveListDataSourceSingleton.selectedObject.firstDataSource.isSelect
        optionOne.value = ActiveListDataSourceSingleton.selectedObject.firstDataSource
    }
}
