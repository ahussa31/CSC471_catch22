//
//  countDownView.swift
//  catch22
//
//  Created by Aemen Hussain on 3/5/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit

class countDownView: UIViewController {
    
    var timer = NSTimer()
    var count:Int = 0
    var mins: String = ""
    
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var countDown: UILabel!

    @IBOutlet weak var tripComplete: UIButton!
    @IBAction func completeTrip(sender: UIButton) {
        performSegueWithIdentifier("toGreeting", sender: tripComplete)
    }
    
    func begin () {
        //check if first index is a 0
      
        let checkForZero = mins.startIndex.advancedBy(1)
        let check = mins.substringToIndex(checkForZero)
        if  (check == "0") {
            mins = mins.substringFromIndex(checkForZero)
            countDown.text = "\(mins)"
            count = Int (mins)!}
         else if (mins == "Approaching now...") {
            countDown.text = "0"
            timer.invalidate()
            ZeroWarning()
            count = 0
            
        } 
        else {
            countDown.text = "\(mins)"
            count = Int (mins)!
        }
    }
    
    
    func update() {
        if(count > 0){
            countDown.text = String(count--)
            countDown.text = "\(count)"
            if (countDown.text == "5"){
                fiveMinWarning()}
        } else {
            countDown.text = "0"
            ZeroWarning()
            timer.invalidate()
        }
    }
    
    
    func fiveMinWarning(){
        if (countDown.text == "5"){
            let alert = UIAlertController (title:"Your bus will be here in 5 min!!!", message: "Are you ready?", preferredStyle: .ActionSheet)
            alert.addAction(UIAlertAction(title: "Sure did!", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            sendNotification("Your bus is 5 mins away!")
        }
    }
    
    func ZeroWarning () {
        if (countDown.text == "0"){
            let alert = UIAlertController (title:"Your bus is here!!!", message: "Did you make it?", preferredStyle: .ActionSheet)
            alert.addAction(UIAlertAction(title: "Sure did!", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            sendNotification("Your bus is here!")
        }
    }

    
    func sendNotification(body:String) {
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 3)
        localNotification.alertBody = body
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        begin()
        timer = NSTimer.scheduledTimerWithTimeInterval(59, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
         mainInstance.arrivalArr = []
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goHome"){
            if let home = segue.destinationViewController as? start {
                home.test = "oh"
               
        }
        }
        if (segue.identifier == "toGreeting") {
            if let greeting = segue.destinationViewController as? GreetingView {
               greeting.test = "test"
            }
        }
    }
    
    
    

}
