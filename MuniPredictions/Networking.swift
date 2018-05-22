//
//  Networking.swift
//  MuniPredictions
//
//  Created by Maribel Montejano on 5/14/18.
//  Copyright © 2018 Maribel Montejano. All rights reserved.
//

import Foundation

// next bus feed base URL
let nextBusBaseURL = URL(string: "http://webservices.nextbus.com/service/publicJSONFeed")!

// URL extension: Use search queries to construct new URL (with key/value pairs as parameters)
extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

// MARK: - Helper method

// creates new URL to query next bus server with described search info
func createURL(route: String, stopTag: String) -> URL? {
    // create query dictionary with selected
    let nextBusQuery: [String: String] = [
        "command": "predictions",
        "a": "sf-muni",
        "r": route,
        "s": stopTag
    ]
    return nextBusBaseURL.withQueries(nextBusQuery)
}

func routeListQueryURL() -> URL? {
    let nextBusQuery: [String: String] = [
        "command": "routeList",
        "a": "sf-muni"
    ]
    return nextBusBaseURL.withQueries(nextBusQuery)
}

func stopListQueryURL(route: String) -> URL? {
    let nextBusQuery: [String: String] = [
        "command": "routeConfig",
        "a": "sf-muni",
        "r": route
    ]
    return nextBusBaseURL.withQueries(nextBusQuery)
}
