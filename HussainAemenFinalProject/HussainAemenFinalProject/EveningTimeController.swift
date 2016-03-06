//
//  EveningTimeController.swift
//  HussainAemenFinalProject
//
//  Created by Aemen Hussain on 2/24/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit

class EveningTimeController: UIViewController {
    @IBOutlet weak var displaytext: UILabel!
    @IBOutlet weak var timedisplay: UILabel!
    
    var message:String = "get me to bed"
    
    //http://www.ctabustracker.com/bustime/api/v1/getpredictions
    //key: fBiEGFmNu8TM3YTvQvGKRQJeD
    //stpid:15399
    //rt: 22
    //top: 10

    override func viewDidLoad() {
        super.viewDidLoad()
        //displaytext.text = message
        timedisplay.text = mainInstance.time

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        displaytext.text = message
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
