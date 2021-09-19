//
//  Model.swift
//  Test App
//
//  Created by Daria on 16.09.2021.
//

import Foundation

struct DevicesResponse: Codable {
    let data: [Device]?
}

struct Device: Codable {
    let id: Int?
    let name: String?
    let icon: String?
    let isOnline: Bool?
    let type: Int?
    let status: String?
    let lastWorkTime: Int?
}
