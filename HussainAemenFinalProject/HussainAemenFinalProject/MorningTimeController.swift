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
    var timeArr:[String] = []
    
    
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
    //remote.connect()
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
            let timeDiff = getTime(arrivalTime)
            timeList.text = timeList.text! + "\(timeDiff)" + "\n"
        }
    }
    
    
    func getTime (time: String) -> String{
        var arrivalTime = time
        var index1 = arrivalTime.startIndex.advancedBy(14)
        var substring1 = arrivalTime.substringToIndex(index1)
        arrivalTime = "\(substring1)"+":00"
        var timeDiff = getTime(arrivalTime)
        print("arrivalTime")
        print(arrivalTime)
        arrivalTime = trimToMin(arrivalTime)
        timeArr.append(arrivalTime)
        return arrivalTime
    }
    

    func trimToMin (timeToTrim : String) -> String {
        var timeInMin = timeToTrim
        var index1 = timeInMin.startIndex.advancedBy(3)
        // var index2 = timeInMin.endIndex.advancedBy(-3)
        var substring1 = timeInMin.substringFromIndex(index1)
        print(substring1)
        index1 = substring1.startIndex.advancedBy(2)
        let substring2 = substring1.substringToIndex(index1)
        print(substring2)
        return substring2
    }
    
    func getTimeDiff (time: String) -> String{
        let string3 = time
        print("oh")
        print(string3)
        
        var index1 = string3.startIndex.advancedBy(4)
        let substring2 = string3.substringFromIndex(index1)
        var substring1 = string3.substringToIndex(index1)
        let sb3 = "\(substring1)-"
        index1 = substring2.startIndex.advancedBy(2)
        let sb2 = substring2.substringFromIndex(index1)
        substring1 = substring2.substringToIndex(index1)
        let sb4 = "\(sb3)\(substring1)-\(sb2)"
        print("arrival time")
        print(sb4)
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let arrivalDate = dateFormatter.dateFromString(sb4)
        
        print("time received from API")
        print(arrivalDate)
        
        let date = NSDate()
        let formatter = NSDateFormatter();
        formatter.dateFormat = "hh:mm:ss";
        print("current time")
        print(date)
        let diff = arrivalDate!.timeIntervalSinceDate(date)
        print("time difference")
        print(diff)
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


}
