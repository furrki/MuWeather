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
    var isLoading = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysTable.delegate = self
        daysTable.dataSource = self
        daysTable.tableFooterView = UIView()
        
        WeatherService.shared.getWeatherData(of: location.woeid) { (weathers) in
            self.weathers.append(contentsOf: weathers)
            self.isLoading = false
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
            dayDetailVC.title = weather.dateString
        }
    }
}

extension DaysVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading {
            return 5
        }
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
            return daysTable.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath)
        }
        
        let cell = daysTable.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DayCell
        cell.initialize(weather: weathers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if weathers.count > 0 {
            performSegue(withIdentifier: "dayDetailsSegue", sender: weathers[indexPath.row])
        }
    }
}
