//
//  countDownView.swift
//  catch22
//
//  Created by Aemen Hussain on 3/5/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit

class countDownView: UIViewController {
    
    
   
    
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
    
    
    func update() {
        if(count > 0)
        {
            countDown.text = String(count--)
            print(count)
            countDown.text = "\(count)"
        } else if (count == 0) {
            countDown.text = "0"
        }else {
            timer.invalidate()
        }}
    
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
        if let home = segue.destinationViewController as? start {
            home.test = "oh"
            //            if let indexPath = self.start.indexPathForSelectedRow {
            //                CDview.mins = alltimes[indexPath.row]
            //            }
        }
        
    }
    
    
    

}
