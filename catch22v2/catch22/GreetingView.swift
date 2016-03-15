//
//  GreetingView.swift
//  catch22
//
//  Created by Aemen Hussain on 3/12/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit

class GreetingView: UIViewController {

    @IBOutlet weak var greeting: UILabel!
    var test = ""
    
    func displayGreeting () {
    if (mainInstance.mode == "morning") {
        greeting.text = "Have a great day at work!"
    } else {
        greeting.text = "Have a wonderful evening!"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayGreeting()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
