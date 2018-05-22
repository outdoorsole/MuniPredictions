//
//  Routes.swift
//  MuniPredictions
//
//  Created by Maribel Montejano on 5/22/18.
//  Copyright © 2018 Maribel Montejano. All rights reserved.
//

import Foundation

struct RouteList: Codable {
    let route: [RouteLine]
    
    enum CodingKeys: String, CodingKey {
        case route = "route"
    }
}

struct RouteLine: Codable {
    let title: String
    let tag: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case tag = "tag"
    }
}
