//
//  hourlyWeatherCell.swift
//  weather-app
//
//  Created by farnaz on 2019-11-02.
//  Copyright © 2019 farnaz. All rights reserved.
//

import UIKit

class hourlyWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    func configData(data : HourlyWeather){
        timeLbl.text = data.time
        tempLbl.text = data.currentTemp
        weatherIcon.image = UIImage(named: data.weatherCondition.rawValue)
    }
}
