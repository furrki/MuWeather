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
        locationTable.tableFooterView = UIView()
        Location.delegate = self
        Location.checkInitLocations()
    }
    
    @IBAction func addLocationButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "New Location", message: "Type a woeid", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "44418"
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            let woeid = textField.text!
            WeatherService.shared.isValidWoeid(woeid: woeid, finish: { (success, cityName) in
                if success {
                    Location.insert(woeid: woeid, name: cityName!)
                }
            })
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "dayTableSegue") {
            let vc = segue.destination as! DaysVC
            let location = sender as! Location
            vc.title = location.name
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Location.locationCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationTable.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! ListCell
        cell.initialize(location: locations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "dayTableSegue", sender: locations[indexPath.row])
    }
}

extension MainVC: LocationDelegate {
    func locationUpdated() {
        DispatchQueue.main.async {
            self.locationTable.reloadData()
        }
    }
}
