//
//  ViewController.swift
//  tips
//
//  Created by Ngo Thanh Tai on 10/28/15.
//  Copyright © 2015 Ngo Thanh Tai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipControl.selectedSegmentIndex = DataModel.getSelectedSegmentIndexByValue(DataModel.loadDoubleValueBy(DataModel.TIP_PERCENTAGE_KEY))
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onValueChanged(sender: AnyObject){
        DataModel.saveDoubleValueBy(DataModel.tipPercentages[tipControl.selectedSegmentIndex], key: DataModel.TIP_PERCENTAGE_KEY)
    }
}

