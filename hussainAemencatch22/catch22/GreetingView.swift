//
//  GreetingView.swift
//  catch22
//
//  Created by Aemen Hussain on 3/12/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit

class GreetingView: UIViewController {

    @IBOutlet weak var home: UIButton!
    @IBAction func goHome(sender: UIButton) {
        performSegueWithIdentifier("toHome", sender: home)
        mainInstance.arrivalArr = []
    }
    @IBOutlet weak var greeting: UILabel!
    var test = ""
    
    func displayGreeting () {
    if (mainInstance.mode == "morning") {
        greeting.text = "Have a great day at work!"
    } else {
        greeting.text = "Have a wonderful evening!"
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toHome"){
            if let CDview = segue.destinationViewController as? start {
                CDview.test = "test"
            }}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayGreeting()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
