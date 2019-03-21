//
//  RoundedView.swift
//  MuWeather
//
//  Created by Admin on 21.03.2019.
//  Copyright © 2019 furrki. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5.0
        layer.borderWidth = 5.0
    }
}
