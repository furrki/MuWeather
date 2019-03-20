//
//  LocationCell.swift
//  MuWeather
//
//  Created by Admin on 20.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initialize(location: Location) {
        print(location.name)
        nameLabel.text = location.name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
