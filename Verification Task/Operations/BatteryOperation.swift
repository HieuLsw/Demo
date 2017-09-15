//
//  BatteryOperation.swift
//  Verification Task
//
//  Created by Hieu on 9/12/17.
//  Copyright © 2017 Hieu. All rights reserved.
//

import UIKit

class BatteryOperation: Operation {
    private var timer: Timer!
    weak var requestToSigmaOperation: RequestToSigmaOperation?
    
    func collectBatteryData(){
        if !self.isCancelled {
            let batterryLevel = Int(UIDevice.current.batteryLevel * 100)
            let info = "Battery: \(batterryLevel)"
            print(info)
            DataManager.sharedInstance.updateData(info)
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                //DispatchQueue.main.async {
                    self.requestToSigmaOperation?.notifyUpdatingCollectedData()
                //}
            }
        }
    }
    func stopCollectingBatteryData() {
        self.timer.invalidate()
        self.timer = nil
    }
    // Override main method
    override func main() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        self.timer = Timer(timeInterval: Constant.RepeatBatteryTimeInterval, target: self, selector: #selector(collectBatteryData), userInfo: nil, repeats: true)
        self.timer.fire()
        let runloop = RunLoop.current
        runloop.add(timer, forMode: .commonModes)
        runloop.run()
    }
    // Override cancel method
    override func cancel() {
        self.stopCollectingBatteryData()
        super.cancel()
    }
    
}
