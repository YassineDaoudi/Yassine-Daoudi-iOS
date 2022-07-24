//
//  Car.swift
//  Guidomia
//
//  Created by Yassine DAOUDI on 22/7/2022.
//

import Foundation

struct Car: Decodable {
    let make: String
    let model: String
    let customerPrice: Double
    let marketPrice: Double
    let rating: Int
    let consList: [String]
    let prosList: [String]
}

struct CarSection: Decodable {
    var isExpanded: Bool
    var cars: [Car]
}

