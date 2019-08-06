//
//  ViewController.swift
//  Upcoming Events
//
//  Created by Alexander Camacho on 7/28/19.
//  Copyright © 2019 Alexander Camacho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let events = Event.getGroupedEvents()
        
        print(events)
    }


}

