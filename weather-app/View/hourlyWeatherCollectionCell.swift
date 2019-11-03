//
//  hourlyWeatherCollectionCell.swift
//  weather-app
//
//  Created by farnaz on 2019-10-30.
//  Copyright © 2019 farnaz. All rights reserved.
//

import UIKit

class hourlyWeatherCollectionCell: UICollectionViewCell {
    
    
    var weatherConditionImg : UIImageView!
    var tempeture : UILabel!
    var time : UILabel!

    
   override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func addViews(){
        time = UILabel()
        configureLabel(lbl: time)
        addSubview(time)
        
        tempeture = UILabel()
        configureLabel(lbl: tempeture)
        addSubview(tempeture)
        
        let imageName = "sun"
        let image = UIImage(named: imageName)
        weatherConditionImg = UIImageView(image: image!)
        weatherConditionImg.frame = CGRect()
        addSubview(weatherConditionImg)
        weatherConditionImg.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureLabel(lbl : UILabel){
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        lbl.font = UIFont(name: "Avenir Next", size: CGFloat(integerLiteral: 14))
        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "test"
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    func configureCell(hour : HourlyWeather)   {
        
        self.time.text = hour.time
        self.tempeture.text = hour.currentTemp
        self.weatherConditionImg.image = UIImage(named: hour.weatherCondition.rawValue)
        configureLayouts()
        // TODO : Set image based on condition
    }
    
    func configureLayouts(){
        NSLayoutConstraint(item: time!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: time!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: weatherConditionImg!, attribute: .top, relatedBy: .equal, toItem: time, attribute: .bottom, multiplier: 1.0, constant: 2.0).isActive = true
        NSLayoutConstraint(item: weatherConditionImg!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: weatherConditionImg!, attribute: .height, relatedBy: .equal, toItem:nil , attribute:.notAnAttribute, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint(item: weatherConditionImg!, attribute: .width, relatedBy: .equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1.0, constant: 10).isActive = true
        
        NSLayoutConstraint(item: tempeture!, attribute: .top, relatedBy: .equal, toItem: weatherConditionImg, attribute: .bottom, multiplier: 1.0, constant: 2.0).isActive = true
        NSLayoutConstraint(item: tempeture!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
    }
    
    
}
