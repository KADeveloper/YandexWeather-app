//
//  StartViewModel.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 28.11.2020.
//

import Foundation

struct StartViewModel {    
    func removeWeatherModel(at index: Int) {
        WeatherModelUserDefaults.shared.recordWeatherModel.remove(at: index)
    }
}
