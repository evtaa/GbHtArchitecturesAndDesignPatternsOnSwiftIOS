//
//  ViewController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 15.12.2020.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var titleUILabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController ()
        // Do any additional setup after loading the view.
    }
    private func setupViewController () {
        titleUILabel.textAlignment = .center
    }
}

