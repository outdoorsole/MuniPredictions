//
//  FavoritesTableViewController.swift
//  MuniPredictions
//
//  Created by Maribel Montejano on 5/22/18.
//  Copyright © 2018 Maribel Montejano. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.favoriteStops.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteStopCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = favorites.favoriteStops[indexPath.row].predictions.routeTag
        cell.detailTextLabel?.text = favorites.favoriteStops[indexPath.row].predictions.stopTitle
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row \(indexPath.row) was tapped")
        selectedRow = indexPath.row
        performSegue(withIdentifier: "favoritePredictionSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue called")
        
        if let destination = segue.destination as? FavoritePredictionTableViewController {
            print(destination)
            
            destination.currentRouteLine = favorites.favoriteStops[selectedRow].predictions.routeTag
            destination.currentStopTag = favorites.favoriteStops[selectedRow].predictions.stopTag
            destination.navigationItem.title = "\(favorites.favoriteStops[selectedRow].predictions.routeTag) Line Predictions"
        }
    }
}
