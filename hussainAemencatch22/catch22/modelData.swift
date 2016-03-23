//
//  ModeManager.swift
//  catch22
//
//  Created by Aemen Hussain on 3/5/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit

class Main {
    var arrivalArr = [String]()
    var mode:String
    init(arrivalArr:[String], mode:String) {
       self.arrivalArr = arrivalArr
       self.mode = mode
    }
}

var mainInstance = Main ( arrivalArr: [], mode: "")


