//
//  WeatherModel.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 28.11.2020.
//

import Foundation

struct WeatherModel:  Codable {
    var geo_object: GeoObject = GeoObject()
    var fact: Fact = Fact()
    var forecasts = [Forecasts]()
}

struct GeoObject: Codable {
    var locality: Locality = Locality()
}

struct Locality: Codable {
    var name: String = ""
}

struct Fact: Codable {
    var temp: Int = 0
    var feels_like: Int = 0
    var condition: String = ""
    var wind_speed: Double = 0.0
    var pressure_mm: Double = 0.0
}

struct Forecasts: Codable {
    var date: String = ""
    var hours = [Hours]()
}

struct Hours: Codable {
    var hour: String = ""
    var temp: Int = 0
}
