//
//  hourlyWeatherCollectionCell.swift
//  weather-app
//
//  Created by farnaz on 2019-10-30.
//  Copyright © 2019 farnaz. All rights reserved.
//

import UIKit

class hourlyWeatherCollectionCell: UICollectionViewCell {
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "4.9+"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
   override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func addViews(){
        addSubview(ratingLabel)
    }
    
}
