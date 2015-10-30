//
//  Currency.swift
//  tips
//
// Á Created by Ngo Thanh Tai on 10/29/15.
//  Copyright © 2015 Ngo Thanh Tai. All rights reserved.
//

import Foundation


class Currency {
    static func symbol()->String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.currencySymbol
    }
    
    static func asLocaleCurrency(value:NSNumber)->String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        formatter.currencySymbol = ""
        return formatter.stringFromNumber(value)!
    }
    
    static func localeCurrencyToNumber(value:String)->Double {
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        var valueAfterReplacing = value.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        valueAfterReplacing = value.stringByReplacingOccurrencesOfString(" ", withString: "")
        valueAfterReplacing = valueAfterReplacing.stringByReplacingOccurrencesOfString(formatter.groupingSeparator, withString: "")
        let divideFor = pow(10.0, Double(formatter.maximumFractionDigits))
 
        valueAfterReplacing = valueAfterReplacing.stringByReplacingOccurrencesOfString(formatter.decimalSeparator, withString: "")
        valueAfterReplacing = valueAfterReplacing.stringByReplacingOccurrencesOfString(formatter.currencySymbol, withString: "")
        
        if valueAfterReplacing.characters.count == 0 {
            valueAfterReplacing = "0"
        }
        
        
        formatter.currencySymbol = ""
        
        return formatter.numberFromString(valueAfterReplacing)!.doubleValue/divideFor
    }
}