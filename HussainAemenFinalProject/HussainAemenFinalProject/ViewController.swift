//
//  ViewController.swift
//  HussainAemenFinalProject
//
//  Created by Aemen Hussain on 2/24/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var message:String = "Select a mode"
    
    @IBOutlet weak var Morning: UIButton!
    @IBAction func SetMorning(sender: UIButton) {
        mainInstance.name = "morning"
        mainInstance.time = getTime()
        
    }
    
    @IBOutlet weak var Evening: UIButton!
    @IBAction func SetEvening(sender: UIButton) {
        mainInstance.name = "evening"
        mainInstance.time = getTime()
    }
    
    
    func getTime ()-> String{
        let date = NSDate()
        let formatter = NSDateFormatter();
        formatter.dateFormat = "HH:mm:ss";
        let now = "\(formatter.stringFromDate(date))"
        // "2015-04-01 08:52:00 -0400" <-- same date, local, but with seconds
        return now
  
    }
    
    override func viewWillAppear(animated: Bool) {
        label.text = message
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "morning" {
            if let target = segue.destinationViewController as? MorningTimeController {
                target.message = "Let's get to work!"

               }
                
            }

        else if segue.identifier == "evening" {
            if let target = segue.destinationViewController as? EveningTimeController {
                        target.message = "Just hold on, we're going home"
                
            }
            
        }

        
    }
    
    @IBAction func unwindToMain(segue : UIStoryboardSegue) {
        if let from = segue.sourceViewController as? MorningTimeController {
            message = "Unwind from YellowViewController"
            
        } else if let from = segue.sourceViewController as? EveningTimeController {
            message = "Unwind from GreenViewController"
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

