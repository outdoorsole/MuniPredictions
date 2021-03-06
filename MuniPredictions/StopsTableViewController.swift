//
//  StopsTableViewController.swift
//  MuniPredictions
//
//  Created by Maribel Montejano on 5/22/18.
//  Copyright © 2018 Maribel Montejano. All rights reserved.
//

import UIKit

class StopsTableViewController: UITableViewController {

    var currentRouteLine: RouteLine?
    var currentStops: RouteStopList?
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("currentRouteLine: \(String(describing: currentRouteLine))")
        getStops()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if currentStops != nil {
            return (currentStops?.route.stop.count)!
        }
        return 0
    }
    
    // MARK: - Helper method
    func getStops() {
        if let url = stopListQueryURL(route: (currentRouteLine?.tag)!) {
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
                    
                    if let result = try? jsonDecoder.decode(RouteStopList.self, from: data) {
                        print("in results")
                        print(result)
                        print("End of Stops List")
                        print("--------------------")
                        self.currentStops = result
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            task.resume()
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = currentStops?.route.stop[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row \(indexPath.row) was tapped")
        selectedRow = indexPath.row
        performSegue(withIdentifier: "predictionsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue called")
        
        if let destination = segue.destination as? StopPredictionTableViewController {
            print(destination)
            
            destination.currentRouteLine = currentRouteLine?.tag
            destination.currentStop = currentStops?.route.stop[selectedRow]
            destination.navigationItem.title = "\((currentRouteLine?.tag)!) Line Predictions"
        }
    }

}
