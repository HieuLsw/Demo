//
//  LocationOperation.swift
//  Verification Task
//
//  Created by Hieu on 9/12/17.
//  Copyright © 2017 Hieu. All rights reserved.
//

import UIKit
import CoreLocation

class LocationOperation: Operation {
    fileprivate var timer: Timer!
    fileprivate var locationManager: CLLocationManager!
    fileprivate var currentLocation: CLLocation?
    weak var requestToSigmaOperation: RequestToSigmaOperation?
    
    //Update Location Info
    func updateLocationInfo() {
        if !self.isCancelled && self.currentLocation != nil{
            let info = "Location: (lat: \(self.currentLocation!.coordinate.latitude), lon: \(self.currentLocation!.coordinate.longitude))"
            print(info)
            DataManager.sharedInstance.updateData(info)
            DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async {
                //DispatchQueue.main.async {
                    self.requestToSigmaOperation?.notifyUpdatingCollectedData()
                //}
            }
        }
    }
    
    //Override main
    override func main() {
        OperationQueue.main.addOperation { 
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.distanceFilter = kCLDistanceFilterNone
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            if #available(iOS 8.0, *) {
                self.locationManager.requestWhenInUseAuthorization()
            }
            self.locationManager.startUpdatingLocation()
        }
        timer = Timer(timeInterval: Constant.RepeatGPSTimeInterval, target: self, selector: #selector(updateLocationInfo), userInfo: nil, repeats: true)
        timer.fire()
        let runloop = RunLoop.current
        runloop.add(timer, forMode: .commonModes)
        runloop.run()
    }
    // cancel
    override func cancel() {
        self.locationManager.stopUpdatingLocation()
        self.timer.invalidate()
        self.timer = nil
        super.cancel()
    }
}

extension LocationOperation: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !self.isCancelled {
            currentLocation = locations.last
        }
    }
}
