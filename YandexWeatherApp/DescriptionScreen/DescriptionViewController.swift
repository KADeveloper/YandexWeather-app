//
//  DescriptionViewController.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 28.11.2020.
//

import UIKit

class DescriptionViewController: UIViewController {
    private let mainView = DescriptionView()
    private let viewModel: DescriptionViewModel
    
    init(viewModel: DescriptionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        initActions()
    }
    
    private func initActions() {
        mainView.backButton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        mainView.likeButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(_:))))
        mainView.likeButton.isUserInteractionEnabled = true
    }
    
    @objc private func onTap(_ sender: UIGestureRecognizer) {
        if mainView.likeButton.tag == 0 {
            mainView.likeButton.tag = 1
            mainView.likeButton.image = UIImage(systemName: "heart.fill")
            viewModel.safeModel()
        } else {
            mainView.likeButton.tag = 0
            mainView.likeButton.image = UIImage(systemName: "heart")
            viewModel.deleteLastModel()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.collectionView.dataSource = self
    }

    @objc private func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.config(cityName: viewModel.model.geo_object.locality.name,
                        temperature: viewModel.model.fact.temp,
                        date: viewModel.model.forecasts[0].date)
    }
}

//MARK: TableViewDataSource, TableViewDelegate
extension DescriptionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherDescriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.cellID, for: indexPath)
        if let cell = cell as? DescriptionCell {
            cell.config(name: viewModel.weatherDescriptions[indexPath.row], value: viewModel.weatherValue[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

//MARK: CollectionViewDataSource
extension DescriptionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model.forecasts[0].hours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCell.cellID, for: indexPath)
        if let cell = cell as? ForecastCell {
            let data = viewModel.model.forecasts[0].hours[indexPath.row]
            cell.config(hour: data.hour, degree: data.temp)
        }
        return cell
    }
}
