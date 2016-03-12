//
//  countDownView.swift
//  catch22
//
//  Created by Aemen Hussain on 3/5/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit

class countDownView: UIViewController {
    

    @IBOutlet weak var tripComplete: UIButton!
    @IBOutlet weak var back: UIButton!
    
    @IBOutlet weak var cd: UILabel!
    @IBOutlet weak var countDown: UILabel!

    var timer = NSTimer()
    var count:Int = 0
    var mins: String = ""
    
    func begin () {
        let checkForZero = mins.startIndex.advancedBy(1)
        let check = mins.substringToIndex(checkForZero)
        
        if  (check == "0") {
            mins = mins.substringFromIndex(checkForZero)
            countDown.text = "\(mins)"
        }
        else {
            countDown.text = "\(mins)"
        }
        count = Int (mins)!

    }
    
    func fiveMinWarning(){
        if (countDown.text == "5"){
            let alert = UIAlertController (title:"Your bus will be here in 5 min!!!", message: "Are you ready?", preferredStyle: .ActionSheet)
            alert.addAction(UIAlertAction(title: "Sure did!", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            sendWarning()
        }
        
    }
    
    func ZeroWarning () {
        if (countDown.text == "0"){
            let alert = UIAlertController (title:"Your bus is here!!!", message: "Did you make it?", preferredStyle: .ActionSheet)
            alert.addAction(UIAlertAction(title: "Sure did!", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            sendNotification()
        }
    }
    
    func update() {
        if(count > 0)
        {
            countDown.text = String(count--)
            print(count)
            countDown.text = "\(count)"
            if (countDown.text == "5"){
                fiveMinWarning()
            }
        } else {
            countDown.text = "0"
            ZeroWarning()
            timer.invalidate()
        }}
    
    func sendNotification() {
        var localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 3)
        localNotification.alertBody = "Your bus is here!"
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func sendWarning() {
        var localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 3)
        localNotification.alertBody = "Your bus is 5 mins away!"
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    @IBAction func completeTrip(sender: UIButton) {
        performSegueWithIdentifier("toGreeting", sender: tripComplete)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cd.text = "\(mins)"
        begin()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goHome"){
            if let home = segue.destinationViewController as? start {
                home.test = "oh"
                mainInstance.arrivalArr = []
            //            if let indexPath = self.start.indexPathForSelectedRow {
            //                CDview.mins = alltimes[indexPath.row]
            //            }
        }
        }
        if (segue.identifier == "toGreeting") {
            if let greeting = segue.destinationViewController as? GreetingView {
               greeting.test = "test"
            }
        }
    }
    
    
    

}
