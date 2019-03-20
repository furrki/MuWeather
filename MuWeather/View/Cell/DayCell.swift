//
//  DayCell.swift
//  MuWeather
//
//  Created by Admin on 21.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit
import Alamofire

class DayCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initialize(weather: Weather) {
        tempLabel.text = "\(weather.temperature)"
        stateLabel.text = weather.description
        dateLabel.text = weather.dateString
        WeatherService.shared.getIcon(of: weather) { (image) in
            DispatchQueue.main.async {
                self.iconImage.image = image
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
