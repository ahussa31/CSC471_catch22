//
//  MorningTimeController.swift
//  HussainAemenFinalProject
//
//  Created by Aemen Hussain on 2/24/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit




class MorningTimeController: UIViewController,NSURLConnectionDelegate,NSXMLParserDelegate {
    
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    
    var message:String = "lets go!"
    
    @IBOutlet weak var timeList: UITextView!
    @IBOutlet weak var displaytext: UILabel!
    @IBOutlet weak var timeView: UILabel!
    
    //http://www.ctabustracker.com/bustime/api/v1/getpredictions
    //key: fBiEGFmNu8TM3YTvQvGKRQJeD
    //stpid:15744
    //rt: 22
    //top: 10
    var data = NSMutableData()
    
    var times = ""
    var timez = ""
    
    //var remote = Remote()
    //let model = modelData()
    
    @IBOutlet weak var getButton: UIButton!
   @IBAction func get(sender: UIButton) {
        connect("")
   }
   
    // var callback = null
    
    
    
    func connect(query:NSString) { //modify to accept 2nd argument - callback fxn --> invoke callback fxn once you have response data
        let url =  NSURL(string: "http://www.ctabustracker.com/bustime/api/v1/getpredictions?key=fBiEGFmNu8TM3YTvQvGKRQJeD&rt=22&stpid=15744&top=60")
        let absoluteURL = url!.absoluteURL
        print("absolute URL = \(absoluteURL)")
        let request = NSURLRequest(URL: url!)
        let conn = NSURLConnection(request: request, delegate: self, startImmediately: true)
        // assign callback as 2nd argument
        
    }
    
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        print("didReceiveResponse")
        let statusCode = (response as? NSHTTPURLResponse)?.statusCode ?? -1
        let data = (response as? NSHTTPURLResponse)
        print("response: \(data)") //prints the XML of the page
        
    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        self.data.appendData(conData)
        
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!)  {
        let dataString = NSString(data: data, encoding:NSUTF8StringEncoding)
        beginParsing()
        //print(dataString)
        times = dataString! as String
        print(times)
        //print("hi"+"\n\n\n")
        //timeList.text = "\(times)"
        var error: NSErrorPointer = nil
        // parse xml into string --> once I have this --> invoke callback w/ formatted data
        // let r = response(times)
  
    }
    
    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(data: data)
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
//        } else if element.isEqualToString("pubDate") {
//            date.appendString(string)
//        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("prd") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "prdtm")
            }
            
            posts.addObject(elements)
            
            var arrivalTime = title1 as String
            print(arrivalTime)
            let timeDiff = getTimeDiff(arrivalTime)
            timeList.text = timeList.text! + "\(timeDiff)" + "\n"
        }
    }
    

//            var index1 = arrivalTime.startIndex.advancedBy(14)
//            var substring1 = arrivalTime.substringToIndex(index1)
//            let string3 = "\(substring1)"+":00"
//            print("oh")
//            print(string3)
//            
//            index1 = string3.startIndex.advancedBy(9)
//            substring1 = string3.substringFromIndex(index1)
//            print(substring1)
//            
//            let dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "yyyyMMdd hh:mm:ss"
//            let arrivalDate = dateFormatter.dateFromString(string3)
//            
//            print("yo")
//            //print(title1)
//            print(arrivalDate)
//         
//            
//            //time diff 
//            
//            //time now
//            let date = NSDate()
//            let formatter = NSDateFormatter();
//            formatter.dateFormat = "hh:mm:ss";
//            let diff = date.timeIntervalSinceDate(arrivalDate!)
//            print(diff)
//            timeList.text = timeList.text! + "\(arrivalTime)" + "\n" + "\(diff)"
            
            
            
//            let date = NSDate()
//            let formatter = NSDateFormatter();
//            formatter.dateFormat = "HH:mm:ss";
//            let now = "\(formatter.stringFromDate(date))"
//            // "2015-04-01 08:52:00 -0400" <-- same date, local, but with seconds
//            return now
            
 
    
    
    func getTimeDiff (time: String) -> String{
        var arrivalTime = time
        var index1 = arrivalTime.startIndex.advancedBy(14)
        var substring1 = arrivalTime.substringToIndex(index1)
        let string3 = "\(substring1)"+":00"
       // let string3 = "20160303 23:35:00"
        print("oh")
        print(string3)
        
        //year
        index1 = string3.startIndex.advancedBy(4)
        var substring2 = string3.substringFromIndex(index1)
        substring1 = string3.substringToIndex(index1)
        //print(substring1)
        //print(substring2)
        
        var sb3 = "\(substring1)-"
        //print(sb3)
        
        index1 = substring2.startIndex.advancedBy(2)
        var substring3 = substring2.substringFromIndex(index1)
        substring1 = substring2.substringToIndex(index1)
        
        var sb4 = "\(sb3)\(substring1)-\(substring3)"
        print(sb4)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let arrivalDate = dateFormatter.dateFromString(sb4)
        
        print("yo")
        //print(title1)
        print(arrivalDate)
        
        let date = NSDate()
        let formatter = NSDateFormatter();
        formatter.dateFormat = "hh:mm:ss";
        print("current date")
        print(date)
        let diff = arrivalDate!.timeIntervalSinceDate(date)
        print(diff)
        let ret = stringFromTimeInterval(diff)
        print(ret)
        
        return ret
        
       // let dateFormatter = NSDateFormatter()
        
//        //dateFormatter.NSTimeZone(abbreviation: "UTC")
////        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
////        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
////        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
//        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
//        let arrivalDate = dateFormatter.dateFromString(sb4)
//        //arrivalDate?.dateByAddingTimeInterval(-21600)
//        
//        print("yo arrival time")
//        //print(title1)
//        print(arrivalDate)
        
        
        //time diff
        
        //time now
//        let date = NSDate()
//        let formatter = NSDateFormatter();
//        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss";
////        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
////        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
////        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
//        let d2 = formatter.stringFromDate(date)
//        print("current time")
//        print(d2)
//        let diff = date.timeIntervalSinceDate(arrivalDate!)
//        print(diff)
//        let ret = stringFromTimeInterval(diff)
//        
//        return ret
    }
    
    func stringFromTimeInterval(interval: NSTimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        //displaytext.text = message
        timeView.text = mainInstance.time
      
        

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
