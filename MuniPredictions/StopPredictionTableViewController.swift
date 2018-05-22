//
//  StopPredictionTableViewController.swift
//  MuniPredictions
//
//  Created by Maribel Montejano on 5/22/18.
//  Copyright © 2018 Maribel Montejano. All rights reserved.
//

import UIKit

class StopPredictionTableViewController: UITableViewController {
    
    var currentStop: Stop?
    var currentPredictions: PredictionsList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStopPredictions(routeTag: "N", stopTag: "4510")
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
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

}
