//
//  StartView.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 28.11.2020.
//

import UIKit

class StartView: UIView {
    let loader = LoadingView()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGray4
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(StartCell.self, forCellReuseIdentifier: StartCell.cellID)
        return tableView
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        initUI()
        initLayout()
    }
    
    private func initUI() {
        addSubview(tableView)
    }
    
    private func initLayout() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
