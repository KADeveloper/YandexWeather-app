//
//  DescriptionViewModel.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 28.11.2020.
//

import Foundation

struct DescriptionViewModel {
    var model = WeatherModel()
    var weatherDescriptions: [String] = []
    var weatherValue: [String] = []
    
    init(model: WeatherModel) {
        self.model = model
        weatherDescriptions = ["feels like", "condition", "wind speed", "pressure"]
        weatherValue = [String(model.fact.feels_like) + " °c", model.fact.condition, String(model.fact.wind_speed) + " м/с", String(model.fact.pressure_mm) + " мм.рт.ст."]
    }
    
    func safeModel() {
        guard !WeatherModelUserDefaults.shared.recordWeatherModel.isEmpty else {
            WeatherModelUserDefaults.shared.recordWeatherModel.append(model)
            return
        }
        for weatherModel in WeatherModelUserDefaults.shared.recordWeatherModel {
            if model.geo_object.locality.name == weatherModel.geo_object.locality.name {
                return
            } else {
                WeatherModelUserDefaults.shared.recordWeatherModel.append(model)
                return
            }
        }
    }
    
    func deleteLastModel() {
        WeatherModelUserDefaults.shared.recordWeatherModel.removeLast()
    }
}
