//
//  DataManager.swift
//  Verification Task
//
//  Created by Hieu on 9/12/17.
//  Copyright © 2017 Hieu. All rights reserved.
//

import UIKit

final class DataManager {
    static let sharedInstance = DataManager()
    private var dataList = SynchronizedArray<String>()
    
    init() {
        
    }
    internal func removeAllData(){
        dataList.removeAll()
    }
    internal func updateData(_ collectedData: String){
        print("Updated info: \(collectedData)")
        dataList.append(collectedData)
    }
    internal func getDataListString() -> String?{
        if dataList.count >= 5 {
            var infoString = "";
            for i in 0 ..< 5{
                if let append = dataList[i] {
                   infoString = infoString.appending(append)
                }
                if i != 4 {
                    infoString = infoString.appending(" - ")
                }
            }
            let removeRange = 0...4
            dataList.removeSubRange(removeRange)
            for i in 0...4{
                dataList.remove(at: i)
            }
            return infoString
        }
        return nil
    }
}
