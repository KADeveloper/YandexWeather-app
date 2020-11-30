//
//  NetworkManager.swift
//  YandexWeatherApp
//
//  Created by Динара Аминова on 28.11.2020.
//

import Foundation
import Alamofire

struct NetworkManager {
    static func getInfo(lat: String, lon: String, completionHandler: @escaping (WeatherModel?, Error?) -> Void) {
        let header: HTTPHeaders = ["X-Yandex-API-Key": "2c5fdf3a-ef0e-4e68-b12f-0238fab1bcde"]
        AF.request("https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)&lang=en_EN&limit=1&hours=true&extra=false",
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: header).response { (responseData) in
            guard let data = responseData.data else {return}
            do {
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                completionHandler(weather, nil)
            } catch let error {
                completionHandler(nil, error)
            }
        }
    }
}
