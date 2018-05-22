//
//  RouteStops.swift
//  MuniPredictions
//
//  Created by Maribel Montejano on 5/22/18.
//  Copyright © 2018 Maribel Montejano. All rights reserved.
//

import Foundation

struct RouteStopList: Codable {
    let route: RouteStop
    
    enum CodingKeys: String, CodingKey {
        case route = "route"
    }
}

struct RouteStop: Codable {
    let title: String
    let routeTag: String
    let stop: [Stop]
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case routeTag = "tag"
        case stop = "stop"
    }
}

struct Stop: Codable {
    let title: String
    let stopTag: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case stopTag = "tag"
    }
}
