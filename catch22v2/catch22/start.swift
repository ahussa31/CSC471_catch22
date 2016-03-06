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
    var date = NSMutableString()

    var data = NSMutableData()
    var times = ""
    var test = ""
    var test2 = NSString()
    var data2 = NSData()
    var message:String = "lets go!"
    
    
    var url = "http://www.ctabustracker.com/bustime/api/v1/getpredictions?key=fBiEGFmNu8TM3YTvQvGKRQJeD&rt=22&stpid=15744&top=60"

  
    var timeArr:[String] = []
    var testArr:[String] = []
    
    
    @IBOutlet weak var timeList: UILabel!
    //var remote = Remote()
    
    @IBOutlet weak var get1: UIButton!

    @IBOutlet weak var get2: UIButton!
    @IBAction func getAction(sender: UIButton) {
        //remote.connect("")
   //     connect("")
//        let time1 = "20160305 18:52:00"
//        let a = getTimeDiff(time1)
//        timeArr.append(a)
//        let time2 = "20160305 19:38:00"
//        let b = getTimeDiff(time2)
//        timeArr.append(b)
        print("timeArr size2")
        print(timeArr.count)
        print("main instance size2")
        print(mainInstance.arrivalArr.count)
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        httpGet (request) {
            (data, error) -> Void in
            if error != nil {
                print(error)
                mainInstance.arrivalArr.append("no arrival times")
            } else {
                self.beginParsing()
                print(data)
                
                print("timeArr size3")
                print(self.timeArr.count)
                print("main instance size3")
                print(mainInstance.arrivalArr.count)
                
            }
         self.performSegueWithIdentifier("onToList", sender: nil)
        }

        

    }
    
//    func start () {
//            var request = NSMutableURLRequest(URL: NSURL(string: url)!)
//            httpGet (request) {
//                (data, error) -> Void in
//                if error != nil {
//                    print(error)
//                } else {
//                    print(data)
//                    
//                }
//            }
//
//    }
//    
    
    func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error!.localizedDescription)
            } else {
                var result = NSString(data: data!, encoding:
                    NSUTF8StringEncoding)!
                self.data2 = data!
                //self.beginParsing()
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
        //data.reloadData()
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
            testArr.append(title1 as String)
            print(title1)
            print("size testArr")
            print(testArr.count)
            var finalTimeStr = title1 as String
            finalTimeStr = getTime(finalTimeStr)
            timeArr.append(finalTimeStr)
            print("timeArr size")
            print(timeArr.count)
            mainInstance.arrivalArr.append(finalTimeStr)
            print("main instance size")
            print(mainInstance.arrivalArr.count)
            
            
//            var arrivalTime = title1 as String
//            print("response")
//            print(arrivalTime)
//            let timeDiff = getTime(arrivalTime)
//            timeArr.append(timeDiff)
//            mainInstance.arrivalArr.append(timeDiff)
//            print("timeDiff")
//            print(timeDiff)
//            var size = mainInstance.arrivalArr.count
//            print("arrivalArr size:")
//            print(size)
//           timeList.text = timeList.text! + "\(timeDiff)" + "\n"
        }
    }


    
    func getTime (time: String) -> String{
        var arrivalTime = time
        var index1 = arrivalTime.startIndex.advancedBy(14)
        var substring1 = arrivalTime.substringToIndex(index1)
        arrivalTime = "\(substring1)"+":00"
        var timeA = getTimeDiff(arrivalTime)
        print("getTime")
        //print(timeA)
        timeA = trimToMin(timeA)
    
        return timeA
    }
    

    
    func trimToMin (timeToTrim : String) -> String {
        var timeInMin = timeToTrim
        var index1 = timeInMin.startIndex.advancedBy(3)
        var substring1 = timeInMin.substringFromIndex(index1)
       // print(substring1)
        index1 = substring1.startIndex.advancedBy(2)
        let substring2 = substring1.substringToIndex(index1)
        print("trim to min")
        //print(substring2)
        return substring2
    }
    
    func getTimeDiff (time: String) -> String{
        let string3 = time
        print("getTimeDiff")
        //print(string3)
        
        var index1 = string3.startIndex.advancedBy(4)
        let substring2 = string3.substringFromIndex(index1)
        var substring1 = string3.substringToIndex(index1)
        let sb3 = "\(substring1)-"
        index1 = substring2.startIndex.advancedBy(2)
        let sb2 = substring2.substringFromIndex(index1)
        substring1 = substring2.substringToIndex(index1)
        let sb4 = "\(sb3)\(substring1)-\(sb2)"
        //print("arrival time")
        //print(sb4)
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let arrivalDate = dateFormatter.dateFromString(sb4)
        
        //print("time received from API")
        print(arrivalDate)
        
        let date = NSDate()
        let formatter = NSDateFormatter();
        formatter.dateFormat = "hh:mm:ss";
        print("current time")
        print(date)
        let diff = arrivalDate!.timeIntervalSinceDate(date)
        //print("time difference")
        //print(diff)
        let ret = stringFromTimeInterval(diff)
        print("time difference formatted")
        print(ret)
        
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
            CDview.timeArr = timeArr
            //CDview.timeArr = mainInstance.arrivalArr
            //            if let indexPath = self.start.indexPathForSelectedRow {
            //                CDview.mins = alltimes[indexPath.row]
            //            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
       timeArr = testArr
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
