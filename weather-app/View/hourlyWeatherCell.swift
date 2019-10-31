//
//  hourlyWeatherCell.swift
//  weather-app
//
//  Created by farnaz on 2019-10-30.
//  Copyright © 2019 farnaz. All rights reserved.
//

import UIKit

class hourlyWeatherCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var collectionview : UICollectionView!
    let collectionCellId = "hourlyCollectionCell"

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.frame.width, height: 50)

        collectionview = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(hourlyWeatherCollectionCell.self, forCellWithReuseIdentifier: collectionCellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white
        self.addSubview(collectionview)
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate : UICollectionViewDelegate & UICollectionViewDataSource, forRow row: Int){
        collectionview.delegate = dataSourceDelegate
        collectionview.dataSource = dataSourceDelegate
        collectionview.tag = row
        collectionview.reloadData()
    }
    


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: collectionCellId, for: indexPath) as! hourlyWeatherCollectionCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {

        return 3
    }
    


    
}
