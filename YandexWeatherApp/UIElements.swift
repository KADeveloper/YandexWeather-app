//
//  UIElements.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 28.11.2020.
//

import UIKit

enum UI {
    static func Label(font: UIFont, color: UIColor,
                      numberOfLines: Int = 1,
                      textAlignment: NSTextAlignment = .left,
                      lineBreakMode: NSLineBreakMode = .byTruncatingTail,
                      apply: ((UILabel) -> Void)? = nil
    ) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.textColor = color
        label.numberOfLines = numberOfLines
        label.lineBreakMode = lineBreakMode
        label.textAlignment = textAlignment
        
        apply?(label)
        
        return label
    }
}
