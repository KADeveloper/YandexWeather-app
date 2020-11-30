//
//  DescriptionView.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 28.11.2020.
//

import UIKit

class DescriptionView: UIView {
    private let cityNameLabel = UI.Label(font: .systemFont(ofSize: 28, weight: .heavy), color: .white, numberOfLines: 2, textAlignment: .center)
    private let temperatureLabel = UI.Label(font: .systemFont(ofSize: 68, weight: .thin), color: .white, numberOfLines: 1, textAlignment: .center)
    private let actualDate = UI.Label(font: .systemFont(ofSize: 12), color: .white, numberOfLines: 1, textAlignment: .left)
    
    let loader = LoadingView()
    
    let likeButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(systemName: "heart")
        imageView.tintColor = .black
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private (set) var backButton: UIButton = {
        let backbutton = UIButton(type: .custom)
        backbutton.translatesAutoresizingMaskIntoConstraints = false
        backbutton.setTitle("Back", for: .normal)
        backbutton.setTitleColor(.black, for: .normal)
        backbutton.layer.borderWidth = 1
        backbutton.layer.cornerRadius = 12
        return backbutton
    }()
    
    let collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumLineSpacing = 16

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: ForecastCell.cellID)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.cellID)
        return tableView
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        initUI()
        initLayout()
    }
    
    private func initUI() {
        addSubview(backButton)
        addSubview(cityNameLabel)
        addSubview(temperatureLabel)
        addSubview(collectionView)
        addSubview(tableView)
        addSubview(actualDate)
        addSubview(likeButton)
        
        likeButton.tag = 0
        tableView.isUserInteractionEnabled = false
        
        if WeatherModelUserDefaults.shared.recordWeatherModel.count > 9 {
            likeButton.isHidden = true
        } else {
            likeButton.isHidden = false
        }
    }
    
    private func initLayout() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 80),
            backButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 25),
            cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            actualDate.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 5),
            actualDate.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func config(cityName: String, temperature: Int, date: String) {
        cityNameLabel.text = cityName
        temperatureLabel.text = String(temperature) + "°"
        actualDate.text = dateConvertation(dateToConvertation: date)
        
        switch temperature {
        case 18...:
            backgroundColor = .red
        case 10..<18:
            backgroundColor = .orange
        case -5..<10:
            backgroundColor = .systemTeal
        default:
            backgroundColor = .darkGray
        }
        
        for model in WeatherModelUserDefaults.shared.recordWeatherModel {
            if model.geo_object.locality.name == cityName {
                likeButton.isHidden = true
                return
            } else {
                likeButton.isHidden = false
            }
        }
    }
    
    private func dateConvertation(dateToConvertation: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM"
        guard let date = dateFormatterGet.date(from: dateToConvertation) else { return "-" }
        let convertedDate = dateFormatterPrint.string(from: date)
        return convertedDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
