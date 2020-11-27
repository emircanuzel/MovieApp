//
//  ViewController.swift
//  MovieApp
//
//  Created by Emircan UZEL on 24.11.2020.
//

import UIKit
//import NVActivityIndicatorView
import ANActivityIndicator

class ViewController: UIViewController {
    
    var indicator: ANActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.indicator = ANActivityIndicatorView(
            frame:  CGRect(x: self.view.frame.size.width/2 - 40, y: self.view.frame.size.height/2 - 104, width: 80, height: 80),
            animationType: .ballSpinFadeLoader,
            color: .white,
            padding: 0)
        
        self.view.addSubview(indicator)
        // Do any additional setup after loading the view.
    }

    
    func showLoading() {
        self.showIndicator()
    }
    
    func stopLoading() {
        self.hideIndicator()
    }
    
    func setNavigationBackButton() {
        let backButton = UIBarButtonItem()
        self.navigationItem.backBarButtonItem = backButton
    }
}


