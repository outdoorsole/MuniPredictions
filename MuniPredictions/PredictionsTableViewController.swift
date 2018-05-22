//
//  PredictionsTableViewController.swift
//  MuniPredictions
//
//  Created by Maribel Montejano on 5/14/18.
//  Copyright © 2018 Maribel Montejano. All rights reserved.
//

import UIKit

class PredictionsTableViewController: UITableViewController, UISearchBarDelegate {

    var searchedStopId: String?
    var currentPredictions: PredictionsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if currentPredictions == nil {
            return 0
        } else {
            return currentPredictions!.predictions.direction.prediction.count
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search bar search button pressed")
        searchBar.resignFirstResponder()
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "predictionCell", for: indexPath)
        
        return cell
    }

}
