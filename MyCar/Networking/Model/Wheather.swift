//
//  wheather.swift
//  MyCar
//
//  Created by Елизавета Федорова on 03.11.2021.
//

import Foundation

struct Wheather : Codable {
        var coord: Coord?
        var weather: [Weather]?
        //var base: String?
        //var visibility: Int?
        //var wind: Wind?
        //var clouds: Clouds?
        //var dt: Int?
        //var sys: Sys?
        //var timezone: Int?
        //var id: Int?
       // var name: String?
        //var cod: Int?
       var main: Main?
    
}

struct Coord: Codable {

    var lon: Double?
    var lat: Double?
}

struct Weather: Codable {

    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Wind: Codable {

    var speed: Double?
    var deg: Int?
    var gust: Double?
}

struct Clouds: Codable {

    var all: Int?
}

struct Sys: Codable {

    var type: Int?
    var id: Int?
    var country: String?
    var sunrise: Int?
    var sunset: Int?

}

struct Main: Codable {

    var temp: Double?
    var feels_like: Double?
    var tempMin: Double?
    var tempMax: Double?
    var pressure: Int?
    var humidity: Int?
    var seaLevel: Int?
    var grndLevel: Int?
}
