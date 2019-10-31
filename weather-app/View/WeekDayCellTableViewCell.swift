//
//  WeekDayCellTableViewCell.swift
//  weather-app
//
//  Created by farnaz on 2019-10-25.
//  Copyright © 2019 farnaz. All rights reserved.
//

import UIKit

class WeekDayCellTableViewCell: UITableViewCell {

    var weekDayLbl: UILabel!
    var weatherConditionImg: UIImageView!
    var highTemp: UILabel!
    var lowTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        weekDayLbl = UILabel()
        configlabels(labelf: weekDayLbl)
        addSubview(weekDayLbl)
        
        let imageName = "sun"
        let image = UIImage(named: imageName)
        weatherConditionImg = UIImageView(image: image!)
//        weatherConditionImg.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        weatherConditionImg.frame = CGRect()
        addSubview(weatherConditionImg)
        weatherConditionImg.translatesAutoresizingMaskIntoConstraints = false
        highTemp = UILabel()
        configlabels(labelf: highTemp)
        addSubview(highTemp)
        
        lowTemp = UILabel()
        configlabels(labelf: lowTemp)
        addSubview(lowTemp)

        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
   
    func configureCell(day: weaklyWeather)   {
        
        self.weekDayLbl.text = day.weekDay
        self.highTemp.text = day.highTemp
        self.lowTemp.text = day.lowTemp
        self.weatherConditionImg.image = UIImage(named: day.weatherCondition.rawValue)
        configureLayouts()
        // TODO : Set image based on condition
    }
    func configureLayouts(){
        NSLayoutConstraint(item: weekDayLbl!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: weekDayLbl!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: weatherConditionImg!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -150.0).isActive = true
        NSLayoutConstraint(item: weatherConditionImg!, attribute: .height, relatedBy: .equal, toItem:nil , attribute:.notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: weatherConditionImg!, attribute: .width, relatedBy: .equal, toItem: nil, attribute:.notAnAttribute, multiplier: 1.0, constant: 30).isActive = true
        NSLayoutConstraint(item: weatherConditionImg!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
         NSLayoutConstraint(item: highTemp!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -80.0).isActive = true
        NSLayoutConstraint(item: highTemp!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: lowTemp!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -10.0).isActive = true
        NSLayoutConstraint(item: lowTemp!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    }
    
    func configlabels(labelf : UILabel){
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        labelf.font = UIFont(name: "Avenir Next", size: CGFloat(integerLiteral: 15))
        labelf.clipsToBounds = true
        labelf.translatesAutoresizingMaskIntoConstraints = false
        labelf.text = "test"
        labelf.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        for subview in self.subviews {
//            subview.removeFromSuperview()
//        }
//    }

}
