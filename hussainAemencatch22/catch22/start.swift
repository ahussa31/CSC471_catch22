//
//  ViewController.swift
//  catch22
//
//  Created by Aemen Hussain on 3/5/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit

class start: UIViewController, NSURLConnectionDelegate, NSXMLParserDelegate  {
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var data = NSMutableData()
    var data2 = NSData()
    var date = NSMutableString()
  
    var test = ""
    var url = ""

    @IBOutlet weak var get1: UIButton!
    @IBOutlet weak var get2: UIButton!
    
    @IBAction func getAction(sender: UIButton) {
        switch sender.tag{
        case 1 : url = "http://www.ctabustracker.com/bustime/api/v1/getpredictions?key=fBiEGFmNu8TM3YTvQvGKRQJeD&rt=22&stpid=15744&top=60"
            mainInstance.mode = "morning"
        case 2: url = "http://www.ctabustracker.com/bustime/api/v1/getpredictions?key=fBiEGFmNu8TM3YTvQvGKRQJeD&rt=22&stpid=15399&top=60"
            mainInstance.mode = "evening"
        default: ()
            break
        }

        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        httpGet (request) {
            (data, error) -> Void in
            if error != nil {
                mainInstance.arrivalArr.append("no arrival times")
            } else {
                self.beginParsing()
            }
         self.performSegueWithIdentifier("onToList", sender: nil)
        }
    }

    
    func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error!.localizedDescription)
            } else {
                let result = NSString(data: data!, encoding:
                    NSUTF8StringEncoding)!
                self.data2 = data!
                callback(result as String, nil)
            }
        }
        task.resume()
    }
    
    
    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(data: data2)
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("prd")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("prdtm") {
            title1.appendString(string)
            
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("prd") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "prdtm")
            }
            
            posts.addObject(elements)
            var finalTimeStr = title1 as String
            finalTimeStr = getTime(finalTimeStr)
            if (finalTimeStr == "00"){
                mainInstance.arrivalArr.append("Approaching now...")
            } else {
                mainInstance.arrivalArr.append(finalTimeStr) }
        }
    }

    
    func getTime (time: String) -> String{
        var arrivalTime = time
        let index1 = arrivalTime.startIndex.advancedBy(14)
        let substring1 = arrivalTime.substringToIndex(index1)
        arrivalTime = "\(substring1)"+":00"
        var timeA = getTimeDiff(arrivalTime)
        timeA = trimToMin(timeA)
        return timeA
    }
    

    
    func trimToMin (timeToTrim : String) -> String {
        let timeInMin = timeToTrim
        var index = timeInMin.startIndex.advancedBy(3)
        let substring1 = timeInMin.substringFromIndex(index)
        index = substring1.startIndex.advancedBy(2)
        let substring2 = substring1.substringToIndex(index)
        return substring2
    }
    
    func getTimeDiff (time: String) -> String{
        let timeString = time
        
        var index = timeString.startIndex.advancedBy(4)
        var substring2 = timeString.substringFromIndex(index)
        let substring1 = timeString.substringToIndex(index)
        index = substring2.startIndex.advancedBy(2)
        let substring3 = substring2.substringFromIndex(index)
        substring2 = substring2.substringToIndex(index)
        let substring4 = "\(substring1)-\(substring2)-\(substring3)"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let arrivalDate = dateFormatter.dateFromString(substring4)
        
        let date = NSDate()
        let formatter = NSDateFormatter();
        formatter.dateFormat = "hh:mm:ss";

        let diff = arrivalDate!.timeIntervalSinceDate(date)
        let ret = stringFromTimeInterval(diff)
        return ret
    }
    
    func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let CDview = segue.destinationViewController as? ListView {
            CDview.test = test
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainInstance.arrivalArr = []
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
