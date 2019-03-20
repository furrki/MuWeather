//
//  MainVC.swift
//  MuWeather
//
//  Created by Admin on 15.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var locationTable: UITableView!
    
    
    var locations: [Location] {
        if let locationObjects = Location.getLocations() {
            return Array(locationObjects)
        }
        return []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTable.delegate = self
        locationTable.dataSource = self
        Location.delegate = self
        Location.checkInitLocations()
    }
    
    @IBAction func addLocationButtonClicked(_ sender: Any) {
        				
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Location.locationCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationTable.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationCell
        cell.initialize(location: locations[indexPath.row])
        return cell
    }
}

extension MainVC: LocationDelegate {
    func locationUpdated() {
        locationTable.reloadData()
    }
}
