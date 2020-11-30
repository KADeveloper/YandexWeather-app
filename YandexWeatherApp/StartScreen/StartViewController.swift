//
//  StartViewController.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 28.11.2020.
//

import UIKit
import MapKit
import Alamofire

class StartViewController: UIViewController {
    private let mainView = StartView()
    private var viewModel = StartViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Enter city name"
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        searchController.searchBar.delegate = self
        
        updateSavedWeatherModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.tableView.reloadData()
    }
    
    private func searchRequest(searchingCityName: String, isUpdate: Bool = false, updateIndex: Int = 0) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchingCityName
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response else {
                self.showAlert(message: "Connection error")
                return
            }
            let center = CLLocationCoordinate2D(latitude: response.boundingRegion.center.latitude, longitude: response.boundingRegion.center.longitude)
            DispatchQueue.main.async {
                self.reguestWeatherInfo(lat: "\(center.latitude)", lon: "\(center.longitude)", isUpdate: isUpdate, updateIndex: updateIndex)
            }
        }
    }
    
    private func reguestWeatherInfo(lat: String, lon: String, isUpdate: Bool = false, updateIndex: Int = 0) {
        NetworkManager.getInfo(lat: lat, lon: lon) { (weather, error) in
            guard let weather = weather else {
                self.showAlert(message: "No city found")
                return
            }
            DispatchQueue.main.async {
                guard !isUpdate else {
                    WeatherModelUserDefaults.shared.recordWeatherModel[updateIndex] = weather
                    self.mainView.tableView.reloadData()
                    return
                }
                self.mainView.loader.hide(withDelay: 0.3)
                let vc = DescriptionViewController(viewModel: DescriptionViewModel(model: weather))
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.present(vc, animated: true)
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: .none, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default) { _ in
            self.mainView.loader.hide(withDelay: 0.5)
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func updateSavedWeatherModel() {
        var timer = Timer()
        timer = Timer(timeInterval: 3600.0, target: self, selector: #selector(updateUDModel), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .default)
    }
    
    @objc private func updateUDModel() {
        for (index, model) in WeatherModelUserDefaults.shared.recordWeatherModel.enumerated() {
            searchRequest(searchingCityName: model.geo_object.locality.name,
                          isUpdate: true,
                          updateIndex: index)
        }
    }
}

//MARK: - TableViewDataSource, TableViewDelegate
extension StartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherModelUserDefaults.shared.recordWeatherModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StartCell.cellID, for: indexPath)
        if let cell = cell as? StartCell {
            guard WeatherModelUserDefaults.shared.recordWeatherModel.isEmpty == false else {
                return UITableViewCell.init()
            }
            let data = WeatherModelUserDefaults.shared.recordWeatherModel[indexPath.row]
            cell.config(cityName: data.geo_object.locality.name,
                        temperature: data.fact.temp)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = WeatherModelUserDefaults.shared.recordWeatherModel[indexPath.row]
        let vc = DescriptionViewController(viewModel: DescriptionViewModel(model: model))
        tableView.reloadData()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeWeatherModel(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

//MARK: - SearchBarDelegate
extension StartViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView.loader.show(in: mainView)
        searchRequest(searchingCityName: searchBar.text ?? "")
        navigationItem.searchController?.isActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
}
