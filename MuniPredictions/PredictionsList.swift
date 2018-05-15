//
//  Predictions.swift
//  MuniPredictions
//
//  Created by Maribel Montejano on 5/15/18.
//  Copyright © 2018 Maribel Montejano. All rights reserved.
//

import Foundation

// Struct modeled to store query data from next bus:
// 1) predictions
struct PredictionsList: Codable {
    let predictions: [Prediction]
    
    enum CodingKeys: String, CodingKey {
        case predictions
    }
}

struct Prediction: Codable {
    let agencyTitle: String
    let routeTag: String
    let routeTitle: String
    let stopTitle: String
    let stopTag: String
    
    enum CodingKeys: String, CodingKey {
        case agencyTitle = "agencyTitle"
        case routeTag = "routeTag"
        case routeTitle = "routeTitle"
        case stopTitle = "stopTitle"
        case stopTag = "stopTag"
    }
}
