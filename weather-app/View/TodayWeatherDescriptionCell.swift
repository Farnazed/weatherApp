//
//  TodayWeatherDescriptionCell.swift
//  weather-app
//
//  Created by farnaz on 2019-10-30.
//  Copyright © 2019 farnaz. All rights reserved.
//

import UIKit

class TodayWeatherDescriptionCell: UITableViewCell {
    var day : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        day = UILabel()
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        day.font = UIFont(name: "Avenir Next", size: CGFloat(integerLiteral: 15))
        day.clipsToBounds = true
        day.translatesAutoresizingMaskIntoConstraints = false
        day.text = "test"
        day.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addSubview(day)
        day.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: day!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: day!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: day!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: day!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
