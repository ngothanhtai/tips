//
//  DataModel.swift
//  tips
//
//  Created by Ngo Thanh Tai on 10/29/15.
//  Copyright © 2015 Ngo Thanh Tai. All rights reserved.
//

import Foundation

class DataModel
{
    static let tipPercentages:[Double] = [0.18,0.2,0.22];
    static let TIP_PERCENTAGE_KEY = "TIP_PERCENTAGE"
    static let LAST_BILL_AMOUNT_KEY = "LAST_BILL_AMOUNT"
    static let LAST_BILL_AMOUNT_TIME_KEY = "LAST_BILL_AMOUNT_TIME"
    static func saveDoubleValueBy(value:Double, key:String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(value, forKey: key)
        defaults.synchronize()
    }
    
    static func loadDoubleValueBy(key:String)->Double {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.doubleForKey(key)
    }
    
    static func getSelectedSegmentIndexByValue(value:Double)->Int
    {
        for var index = 0; index < tipPercentages.count; ++index {
            
            if(tipPercentages[index] == value)
            {
                return index
            }
        }
        
        return 0
    }

    static func saveLastInput(value:Double) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setDouble(value, forKey: LAST_BILL_AMOUNT_KEY)
        defaults.setValue(NSDate(), forKey: LAST_BILL_AMOUNT_TIME_KEY)
        defaults.synchronize()
    }
    
    static func getLastInput()->Double {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let amount = defaults.doubleForKey(LAST_BILL_AMOUNT_KEY)
        let lastDateObject = defaults.objectForKey(LAST_BILL_AMOUNT_TIME_KEY)
        if lastDateObject == nil
        {
            return 0
        }
        
        let lastDate = lastDateObject as! NSDate

        let currentDate = NSDate()
        let distanceBetweenDates = currentDate.timeIntervalSinceDate(lastDate)
        let secondsInAnMinute = 60.0;
        let minutesElapsed = distanceBetweenDates / secondsInAnMinute;
        if minutesElapsed < 10
        {
            return amount
        }
        return 0
    }
}

class LastInputModel {
    var amount:Double = 0
    var date:NSDate = NSDate()
}