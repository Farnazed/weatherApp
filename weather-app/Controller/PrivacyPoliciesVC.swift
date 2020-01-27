//
//  PrivacyPoliciesVC.swift
//  weather-app
//
//  Created by farnaz on 2020-01-27.
//  Copyright © 2020 farnaz. All rights reserved.
//

import UIKit
import WebKit

class PrivacyPoliciesVC: UIViewController {
    
    let privacy_policy_URL = "https://github.com/Farnazed/weatherApp/commit/585d9fdac30bb44d7e4f1859a8dd2f6171e626f3"
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

         let request = URLRequest(url: Foundation.URL(string: "https://github.com/Farnazed/weatherApp/commit/585d9fdac30bb44d7e4f1859a8dd2f6171e626f3")!)
        webView.load(request)
    }
    
  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
