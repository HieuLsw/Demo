//
//  RequestToSigmaOperation.swift
//  Verification Task
//
//  Created by Hieu on 9/12/17.
//  Copyright © 2017 Hieu. All rights reserved.
//

import UIKit

class RequestToSigmaOperation: Operation {
    
    //Override main method
    override func main() {
        //Keep this operation running
        let runloop = RunLoop.current
        runloop.add(Port(), forMode: .defaultRunLoopMode)
        runloop.run()
    }
    
    // Notify 
    
    func notifyUpdatingCollectedData() {
        let inforString = DataManager.sharedInstance.getDataListString()
        if let string = inforString {
            print("String to send => \(string)");
            let url = URL(string: "http://sigma-solutions.eu/test")
            var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
            request.httpMethod = "POST"
            request.httpBody = inforString?.data(using: String.Encoding.utf8)
            URLSession.shared.dataTask(with: request).resume()
        }
    }
}
