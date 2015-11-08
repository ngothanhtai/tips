//
//  ViewController.swift
//  tips
//
//  Created by Ngo Thanh Tai on 10/28/15.
//  Copyright © 2015 Ngo Thanh Tai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateClearButton(true)
        
        tipLabel.text = "\(Currency.symbol()) \(Currency.asLocaleCurrency(0))"
        totalLabel.text = tipLabel.text

        tipControl.selectedSegmentIndex = DataModel.getSelectedSegmentIndexByValue(DataModel.loadDoubleValueBy(DataModel.TIP_PERCENTAGE_KEY))
        
        let lastBillAmount = DataModel.getLastInput()
        if lastBillAmount == 0 {
            self.billField.placeholder = "Bill Amount (\(Currency.symbol()))"
        }
        else
        {
            self.billField.text = Currency.asLocaleCurrency(lastBillAmount)
            
            onEditingChange(self.billField)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        tipControl.selectedSegmentIndex = DataModel.getSelectedSegmentIndexByValue(DataModel.loadDoubleValueBy(DataModel.TIP_PERCENTAGE_KEY))
        onEditingChange(self.billField)
    }
    
    override func viewDidAppear(animated: Bool) {

        billField.becomeFirstResponder()
        
    }

    @IBAction func onEditingChange(sender: AnyObject) {
        
        let tipPercentage = DataModel.tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = Currency.localeCurrencyToNumber(billField.text!)
        billField.text = "\(Currency.symbol()) \(Currency.asLocaleCurrency(billAmount))"
        
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = "\(Currency.symbol()) \(Currency.asLocaleCurrency(tip))"
        totalLabel.text = "\(Currency.symbol()) \(Currency.asLocaleCurrency(total))"
        
        animateClearButton(billAmount == 0)
        saveLastBillAmount(billAmount)
    }
    
    func animateClearButton(hidden:Bool) {
        if hidden {
            UIView.animateWithDuration(0.5, animations: {
                self.clearButton.transform = CGAffineTransformMakeScale(0.5, 0.5)
                self.clearButton.alpha = 0
            });
        }
        else {
            UIView.animateWithDuration(0.5, animations: {
                self.clearButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                self.clearButton.alpha = 1
            });
        }
    }
    
    // MARK: Save last Bill Amount
    func saveLastBillAmount(billAmount:Double) {
        DataModel.saveLastInput(billAmount)
    }

    @IBAction func clear(sender: AnyObject) {
        billField.text = "";
        billField.becomeFirstResponder()
        onEditingChange(billField)
    }
}

