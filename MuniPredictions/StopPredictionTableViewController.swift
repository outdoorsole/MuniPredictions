//
//  StopPredictionTableViewController.swift
//  MuniPredictions
//
//  Created by Maribel Montejano on 5/22/18.
//  Copyright © 2018 Maribel Montejano. All rights reserved.
//

import UIKit

class StopPredictionTableViewController: UITableViewController {
    var currentRouteLine: String?
    var currentStop: Stop?
    var currentPredictions: PredictionsList?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStopPredictions(routeTag: currentRouteLine!, stopTag: (currentStop?.stopTag)!)
        print("currentRouteLine: \(String(describing: currentRouteLine))")
        print("currentStop: \(currentStop!)")
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if currentPredictions != nil {
            return (currentPredictions?.predictions.direction.prediction.count)!
        }
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopPredictionCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "\((currentPredictions?.predictions.direction.prediction[indexPath.row].minutes)!) minutes"
        
        return cell
    }

    
    // MARK: - Helper method
    func getStopPredictions(routeTag: String, stopTag: String) {
        if let url = createStopPredictionListURL(routeTag: routeTag, stopTag: stopTag) {
            print(url)
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                print("in the completion handler for data task")
                
                if let error = error {
                    print("error: \(error)")
                    return
                }
                
                if let data = data {
                    print("data \(data)")
                    let jsonDecoder = JSONDecoder()
                    
                    if let result = try? jsonDecoder.decode(PredictionsList.self, from: data) {
                        print("in results")
                        print(result)
                        print("End of Stop Predictions List")
                        print("--------------------")
                        self.currentPredictions = result
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            task.resume()
        }
    }

    @IBAction func addToFavoritesPressed(_ sender: UIButton) {
        print("Add to favorites button pressed")
        favorites.favoriteStops.append(currentPredictions!)
    }
    
}
