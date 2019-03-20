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
        
        WeatherService.shared.getWeatherData(of: location.woeid) { (weathers) in
            self.weathers.append(contentsOf: weathers)
            weathers.forEach({ (w) in
                print(w.longDescription)
            })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DaysVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
