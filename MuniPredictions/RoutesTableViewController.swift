//
//  RoutesTableViewController.swift
//  MuniPredictions
//
//  Created by Maribel Montejano on 5/22/18.
//  Copyright © 2018 Maribel Montejano. All rights reserved.
//

import UIKit

class RoutesTableViewController: UITableViewController {

    var currentRoutes: RouteList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get current routes
        getRoutes()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if currentRoutes != nil {
            return (currentRoutes?.route.count)!
        }
        return 0
    }

    // MARK: - Helper method
    func getRoutes() {
        if let url = routeListQueryURL() {
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
                    
                    if let result = try? jsonDecoder.decode(RouteList.self, from: data) {
                        print("in results")
                        print(result)
                        self.currentRoutes = result
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = currentRoutes?.route[indexPath.row].title
        cell.detailTextLabel?.text = currentRoutes?.route[indexPath.row].tag
        
        return cell
    }

}
