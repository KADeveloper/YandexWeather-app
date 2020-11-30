//
//  UserDefaults.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 30.11.2020.
//

import Foundation

struct WeatherModelUserDefaults {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    static var shared = WeatherModelUserDefaults()
    
    private var recordWeatherModelKey: String {
        return "recordWeatherModelKey"
    }
    
    var recordWeatherModel: [WeatherModel] {
        get {
            guard let encodedData = UserDefaults.standard.array(forKey: recordWeatherModelKey) as? [Data] else {
                return []
            }
            return encodedData.map { try! decoder.decode(WeatherModel.self, from: $0)}
        }
        set {
            let data = newValue.map { try? encoder.encode($0)}
            UserDefaults.standard.set(data, forKey: recordWeatherModelKey)
        }
    }
}
