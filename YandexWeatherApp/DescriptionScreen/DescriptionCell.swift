//
//  DescriptionCell.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 28.11.2020.
//

import UIKit

class DescriptionCell: UITableViewCell {
    //MARK: - Properties
    static var cellID: String { return String(describing: self) }
    
    //MARK: - UI elements
    private let descriptionNameLAbel = UI.Label(font: .systemFont(ofSize: 18, weight: .regular), color: .white, numberOfLines: 1, textAlignment: .left)
    
    private let descriptionValueLabel = UI.Label(font: .systemFont(ofSize: 18, weight: .regular), color: .white, numberOfLines: 1, textAlignment: .right)
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.borderWidth = 0.3
        selectionStyle = .none
        backgroundColor = .clear

        contentView.addSubview(descriptionNameLAbel)
        contentView.addSubview(descriptionValueLabel)
        initLayout()
    }
    
    private func initLayout() {
        NSLayoutConstraint.activate([
            descriptionNameLAbel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionNameLAbel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionNameLAbel.trailingAnchor.constraint(lessThanOrEqualTo: descriptionValueLabel.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            descriptionValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            descriptionValueLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 10)
        ])
        
        descriptionValueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func config(name: String, value: String) {
        descriptionNameLAbel.text = name
        descriptionValueLabel.text = value
    }
}

