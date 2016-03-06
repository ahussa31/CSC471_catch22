//
//  ModeManager.swift
//  HussainAemenFinalProject
//
//  Created by Aemen Hussain on 2/24/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit

class Main {
    var name:String
    var time:String
    var response:String
    init(name:String, time:String, response:String) {
        self.name = name
        self.time = time
        self.response = response
    }

}

var mainInstance = Main(name:"My Global Class",time:"", response:"")

