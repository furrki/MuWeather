//
//  DaysVC.swift
//  MuWeather
//
//  Created by Admin on 20.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit

class DaysVC: UIViewController {
    
    @IBOutlet weak var daysTable: UITableView!
    var location: Location!
    var weathers: [Weather] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysTable.delegate = self
        daysTable.dataSource = self
        daysTable.tableFooterView = UIView()
        
        WeatherService.shared.getWeatherData(of: location.woeid) { (weathers) in
            self.weathers.append(contentsOf: weathers)
            self.refreshTable()
        }
    }
    
    func refreshTable() {
        DispatchQueue.main.async {
            self.daysTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dayDetailVC = segue.destination as? DayDetailVC, let weather = sender as? Weather {
            dayDetailVC.location = location
            dayDetailVC.weather = weather
        }
    }
}

extension DaysVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = daysTable.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DayCell
        cell.initialize(weather: weathers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "dayDetailsSegue", sender: weathers[indexPath.row])
    }
}
