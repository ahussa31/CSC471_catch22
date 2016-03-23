//
//  ListView.swift
//  catch22
//
//  Created by Aemen Hussain on 3/5/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit

class ListView: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    var timeArr: [String] = mainInstance.arrivalArr
    var test:String = ""

    var subtext = "minutes remaining"
    
    @IBOutlet weak var timeDiffView: UITextField!
    @IBOutlet weak var diffList: UITableView!
    
    
    @IBOutlet weak var home: UIButton!
    @IBAction func goHome(sender: UIButton) {
        performSegueWithIdentifier("toHome", sender: home)
        mainInstance.arrivalArr = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.diffList.registerClass(UITableViewCell.self, forCellReuseIdentifier: "groupcell")
        diffList.delegate = self
        diffList.dataSource = self
        timeArr = mainInstance.arrivalArr
    }
    
    
    func tableView(diffList: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArr.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(diffList: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = diffList.dequeueReusableCellWithIdentifier("timeLeft", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.timeArr[indexPath.row]
        cell.detailTextLabel!.text = subtext
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if (segue.identifier == "toGreeting"){
     
        if (segue.identifier == "toHome"){
            if let CDview = segue.destinationViewController as? start {
               CDview.test = "test"
            }
        } else {
            if let CDview = segue.destinationViewController as? countDownView {
                if let indexPath = self.diffList.indexPathForSelectedRow {
                    CDview.mins = timeArr[indexPath.row]
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
