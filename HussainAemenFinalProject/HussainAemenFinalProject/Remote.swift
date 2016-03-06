//
//  Remote.swift
//  HussainAemenFinalProject
//
//  Created by Aemen Hussain on 2/29/16.
//  Copyright © 2016 Aemen Hussain. All rights reserved.
//

import UIKit



class Remote: NSObject {
 
    
    var data = NSMutableData()
    
    var times = ""
    // var callback = null
  
    
    
    func connect(query:NSString) { //modify to accept 2nd argument - callback fxn --> invoke callback fxn once you have response data
        let url =  NSURL(string: "http://www.ctabustracker.com/bustime/api/v1/getpredictions?key=fBiEGFmNu8TM3YTvQvGKRQJeD&rt=22&stpid=15744&top=60")
        let absoluteURL = url!.absoluteURL
        print("absolute URL = \(absoluteURL)")
        let request = NSURLRequest(URL: url!)
        let conn = NSURLConnection(request: request, delegate: self, startImmediately: true)
        // assign callback as 2nd argument
       
    }
    
    
    func connection1(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        print("didReceiveResponse")
        let statusCode = (response as? NSHTTPURLResponse)?.statusCode ?? -1
        let data = (response as? NSHTTPURLResponse)
        print("response: \(data)") //prints the XML of the page

    }
    
    func connection2(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        self.data.appendData(conData)

    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) -> String {
        let dataString = NSString(data: data, encoding:NSUTF8StringEncoding)
       // print(dataString)
        times = dataString! as String
        //print("hi"+"\n\n\n")
        print(times)
        mainInstance.response = times
        var error: NSErrorPointer = nil
        // parse xml into string --> once I have this --> invoke callback w/ formatted data
       // let r = response(times)
        return times
    }
    
//    func response (times: String) -> String{
//        var resp = times
//        return resp 
//    }
//    
    
    deinit {
        print("deiniting")
    }
}
