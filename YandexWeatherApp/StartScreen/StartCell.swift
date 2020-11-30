//
//  StartCell.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 28.11.2020.
//

import UIKit

class StartCell: UITableViewCell {
    //MARK: - Properties
    static var cellID: String { return String(describing: self) }
    
    //MARK: - UI elements
    private let cityNameLAbel = UI.Label(font: .systemFont(ofSize: 18, weight: .medium), color: .white, numberOfLines: 2, textAlignment: .left)
    
    private let temperatureLabel = UI.Label(font: .systemFont(ofSize: 24, weight: .bold), color: .white, numberOfLines: 1, textAlignment: .right)
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.borderWidth = 0.3
        selectionStyle = .none

        contentView.addSubview(cityNameLAbel)
        contentView.addSubview(temperatureLabel)
        initLayout()
    }
    
    private func initLayout() {
        NSLayoutConstraint.activate([
            cityNameLAbel.centerYAnchor.constraint(equalTo: centerYAnchor),
            cityNameLAbel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cityNameLAbel.trailingAnchor.constraint(lessThanOrEqualTo: temperatureLabel.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            temperatureLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        
        temperatureLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func config(cityName: String, temperature: Int) {
        cityNameLAbel.text = cityName
        temperatureLabel.text = String(temperature) + " °C"
        
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
    }
}

