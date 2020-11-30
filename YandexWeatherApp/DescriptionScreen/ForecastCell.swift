//
//  ForecastCell.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 28.11.2020.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    //MARK: - Properties
    static var cellID: String { return String(describing: self) }
    
    //MARK: - UI elements
    private let hourLabel = UI.Label(font: .systemFont(ofSize: 12, weight: .regular), color: .white, numberOfLines: 1, textAlignment: .center)
    private let degreeLabel = UI.Label(font: .systemFont(ofSize: 12, weight: .regular), color: .white, numberOfLines: 1, textAlignment: .center)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initLayout()
    }
    
    private func initUI() {
        backgroundColor = .clear
        
        contentView.addSubview(hourLabel)
        contentView.addSubview(degreeLabel)
    }
    
    private func initLayout() {
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            hourLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            degreeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            degreeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func config(hour: String, degree: Int) {
        hourLabel.text = hour
        degreeLabel.text = String(degree) + "°"
    }
}
