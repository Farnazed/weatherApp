//
//  ViewController.swift
//  weather-app
//
//  Created by farnaz on 2019-10-24.
//  Copyright © 2019 farnaz. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate,  UITableViewDelegate{
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var currentWeatherStack: UIStackView!
    @IBOutlet weak var todayWeatherDescriptionStack: UIStackView!
    
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dayLblText: UILabel!
    @IBOutlet weak var cityLblText: UILabel!
    @IBOutlet weak var degreeLblText: UILabel!
    @IBOutlet weak var precipTypeLblText: UILabel!
    @IBOutlet weak var summaryLblText: UILabel!
    @IBOutlet weak var apparentTemperatureHighLblText: UILabel!
    @IBOutlet weak var apparentTemperatureLowLblText: UILabel!
    @IBOutlet weak var windSpeedLblText: UILabel!
    @IBOutlet weak var uvIndexLblText: UILabel!
    @IBOutlet weak var weakWeatherView: UIView!
    @IBOutlet weak var hightConstraint: NSLayoutConstraint!
    // TODO put the week data
    // let week : [Int:[String]] = []
    
    //variables
    weak var tableView : UITableView!
    var latitude  = "51.044270"
    var longtitude = "-114.062019"
    var tableIsCreated = false
    var weeklyWeather : [[String : AnyObject]]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(showWeeklyWeather))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(hideWeeklyWeather))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        retriveWeatherByLocation()
        // TODO : post a notification that lcoation is not null and call fetchWeatherByLocation function
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        retriveWeatherByLocation()
        retriveWeatherForWeek()
        self.view.layoutSubviews()
    }
    
    @objc func showWeeklyWeather(){
        self.weakWeatherView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.hightConstraint.constant = 260.0
            self.view.layoutIfNeeded()
        })
        if !tableIsCreated{
            tableIsCreated = true
            customizeTable()
        }
        
        
    }
    func customizeTable(){
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.weakWeatherView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.weakWeatherView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: tableView.topAnchor),
            self.weakWeatherView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.weakWeatherView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            self.weakWeatherView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
        self.tableView = tableView
        self.tableView.allowsSelection = false
        self.tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "weakDayCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Conditon")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    
    @objc func hideWeeklyWeather(){
        UIView.animate(withDuration: 0.3) {
            self.hightConstraint.constant = 0.0
            self.view.layoutIfNeeded()
            self.view.layoutSubviews()
        }
    }
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        latitude = String(locValue.latitude)
        longtitude = String(locValue.longitude)
        
    }
    
    func retriveWeatherByLocation(){        Alamofire.request("\(URL)\(SECRET_KEY)/\(latitude),\(longtitude)?units=ca").responseJSON { (response) in
        
        guard let json = response.result.value as? Dictionary<String, AnyObject> else {return}
        let currentWeather = json["currently"] as! [String : AnyObject]
        let hourlyWeather = json["hourly"] as! Dictionary<String, AnyObject>
        let weather = json["daily"] as! Dictionary<String, AnyObject>
        let weeklyWeather = weather["data"] as! [[String : AnyObject]]
        //print(weeklyWeather)
        let dayOne = weeklyWeather.first!
        //print(currentWeather)
        print(String(describing: dayOne["time"]!))
        print(self.getDayOfWeek( self.createDateTime(timestamp: String(describing: dayOne["time"]!)))!)
        self.dayLblText.text = self.getTodaysDate()
        self.cityLblText.text = "Calgary"
        let temperature = currentWeather["temperature"] as! NSNumber
        self.degreeLblText.text = String(describing: Int(round(temperature.floatValue))) + "°"
        self.precipTypeLblText.text = String(describing:currentWeather["summary"]!)
        self.summaryLblText.text = String(describing: hourlyWeather["summary"]!)
        self.apparentTemperatureHighLblText.text = String(describing: Int(round((dayOne["temperatureHigh"] as! NSNumber).floatValue))) + "°"
        self.apparentTemperatureLowLblText.text = String(describing: Int(round((dayOne["temperatureLow"] as! NSNumber).floatValue))) + "°"
        self.windSpeedLblText.text = String(describing:currentWeather["windSpeed"]!)
        self.uvIndexLblText.text = String(describing:currentWeather["uvIndex"]!)
        
        }
    }
    
    func retriveWeatherForWeek(){
        Alamofire.request("\(URL)\(SECRET_KEY)/\(latitude),\(longtitude)?units=ca").responseJSON { (response) in
            
            guard let json = response.result.value as? Dictionary<String, AnyObject> else {return}
            let weather = json["daily"] as! Dictionary<String, AnyObject>
            self.weeklyWeather = (weather["data"] as! [[String : AnyObject]])
            
        }
        
    }
    
    func getTodaysDate()->(String){
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.weekday, from: date)
        
        switch day {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return ""
        }
    }
    func createDateTime(timestamp: String) -> String {
        var strDate = "undefined"
        
        if let unixTime = Double(timestamp) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
            dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd.MM.yyyy" // HH:mm  Specify your format that you want
            strDate = dateFormatter.string(from: date)
            
        }
        return strDate
    }
    // returns an integer from 1 - 7, with 1 being Sunday and 7 being Saturday
    func getDayOfWeek(_ today:String) -> String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        switch weekDay {
        case 1:
            return "Sunday"
        case 2 :
            return "Monday"
        case 3 :
            return "TuesDay"
        case 4:
            return "WednesDay"
        case 5 :
            return "Thursday"
        case 6 :
            return "Friday"
        case 7 :
            return "Saturday"
        default:
            return "Noday"
        }
        
    }
    
    
    
    
}


extension ViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let day = weeklyWeather![indexPath.row]
        print("Im inside tableView indexPath.item is \(indexPath.item)")
        var count = 0
        
        if  indexPath.item != 8  {
            print("258")
            for day in weeklyWeather{
                if count == indexPath.item  {
                    print("count is \(count)")
                    let cell = WeekDayCellTableViewCell(style:  UITableViewCell.CellStyle.default, reuseIdentifier: "weakDayCell")
                    var week = weaklyWeather()
                    week.highTemp = String(describing:Int(round((day["temperatureHigh"] as! NSNumber).floatValue))) + "°"
                    week.lowTemp = String(describing:Int(round((day["temperatureLow"] as! NSNumber).floatValue))) + "°"
                    week.weatherCondition = WeatherCondition.init(rawValue: day["icon"] as! String)!
                    week.weekDay =  self.getDayOfWeek( self.createDateTime(timestamp: String(describing: day["time"]!)))!
                    cell.configureCell(day: week)
                    print("---------")
                    return cell
                }
                count = count + 1
            }
        }
        
        if indexPath.item == 8{
            let cell2= TodayWeatherDescriptionCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Conditon")
            
            cell2.textLabel?.text = "kkkkkkkkkkkkkkk"
            print("---------")
            return cell2
        }
        return UITableViewCell()
    }
}

