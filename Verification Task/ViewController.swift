//
//  ViewController.swift
//  Verification Task
//
//  Created by Hieu on 9/12/17.
//  Copyright © 2017 Hieu. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    var taskQueue: OperationQueue!
    override func viewDidLoad() {
        super.viewDidLoad()
        // init first UI
        stopButton.isEnabled = false
        stopButton.backgroundColor = ColorSchema.inActiveButtonColor()
        startButton.isEnabled = true
        startButton.backgroundColor = ColorSchema.activeButtonColor()
        // Init operation queue
        taskQueue = OperationQueue()
        taskQueue.maxConcurrentOperationCount = 3
       let  button = UIButton()
        button.currentTitleColor
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
//MARK: IBAction Handle
extension ViewController{
    //Start button handle
    @IBAction func doStart(_ sender: Any) {
        let requestToSigmaOperation = RequestToSigmaOperation()
        let locationOperation = LocationOperation()
        locationOperation.requestToSigmaOperation = requestToSigmaOperation
        let batteryOperation = BatteryOperation()
        batteryOperation.requestToSigmaOperation = requestToSigmaOperation
        taskQueue.isSuspended = true
        taskQueue.addOperation(batteryOperation)
        taskQueue.addOperation(locationOperation)
        taskQueue.addOperation(requestToSigmaOperation)
        taskQueue.isSuspended = false
        startButton.isEnabled = false
        startButton.backgroundColor = ColorSchema.inActiveButtonColor()
        stopButton.isEnabled = true
        stopButton.backgroundColor = ColorSchema.activeButtonColor()
        
    }
    //Stop button handle
    @IBAction func doStop(_ sender: Any) {
        taskQueue.cancelAllOperations()
        DataManager.sharedInstance.removeAllData()
        startButton.isEnabled = true
        startButton.backgroundColor = ColorSchema.activeButtonColor()
        stopButton.isEnabled = false
        stopButton.backgroundColor = ColorSchema.inActiveButtonColor()
        
    }
    
}
