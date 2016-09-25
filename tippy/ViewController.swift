//
//  ViewController.swift
//  tippy
//
//  Created by Serge Nasr on 2016-09-17.
//  Copyright © 2016 Serge Nasr. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipButton: UIButton!
    
    var tipArrIndex = 0
    var tipPercentages : [Float] = [0.18, 0.2, 0.25]
    var defaultPercentage = 0.18
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Tip button without borders
        tipButton.layer.borderWidth = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get default values
        let defaults = NSUserDefaults.standardUserDefaults()
        let billValue = defaults.doubleForKey("DEFAULT_BILL")
        billField.text = String(format: "%.2f", billValue)
        let tipValue = defaults.doubleForKey("DEFAULT_TIP")
        tipLabel.text = String(format: "$%.2f", tipValue)
        let totalValue = defaults.doubleForKey("DEFAULT_TOTAL")
        totalLabel.text = String(format: "$%.2f", totalValue)
        tipArrIndex = defaults.integerForKey("DEFAULT_TIP_BUTTON")
        defaultPercentage = Double(tipPercentages[tipArrIndex])
        let tipPercentage = defaultPercentage * 100
        let tipPercentageText = String(format: "%.0f%%", tipPercentage)
        tipButton.setTitle(tipPercentageText, forState: UIControlState.Normal)
        
        // Automatically show keyboard on load
        billField.becomeFirstResponder()
        
        // Gradient background
        let bottomColor = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha: 1)
        let topColor = UIColor(red: (65/255.0), green: (66/255.0), blue: (144/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations : [Float] = [0.0, 1.0]
        
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
    }

    @IBAction func tipPercentageOnTap(sender: AnyObject) {
        tipArrIndex = (tipArrIndex + 1) % 3
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipArrIndex, forKey: "DEFAULT_TIP_BUTTON")
        defaults.synchronize()
        
        defaultPercentage = Double(tipPercentages[tipArrIndex])
        let tipPercentage = defaultPercentage * 100
        let tipPercentageText = String(format: "%.0f%%", tipPercentage)
        tipButton.setTitle(tipPercentageText, forState: UIControlState.Normal)
    }
    
    @IBAction func calculateTip(sender: AnyObject) {
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * defaultPercentage
        let total = tip + bill
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(bill, forKey: "DEFAULT_BILL")
        defaults.setDouble(tip, forKey: "DEFAULT_TIP")
        defaults.setDouble(total, forKey: "DEFAULT_TOTAL")
        defaults.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let themeClass = themeSingletonClass.themeInstance
        if (themeClass.theme == "DARK") {
            applyDarkTheme()
        }
        else {
            applyLightTheme()
        }
    }
    
    @IBAction func applyDarkTheme() {
        
        // Gradient background
        let bottomColor = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha: 1)
        let topColor = UIColor(red: (65/255.0), green: (66/255.0), blue: (144/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations : [Float] = [0.0, 1.0]
        
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = self.view.bounds
        let oldLayer = self.view.layer.sublayers![0]
        self.view.layer.replaceSublayer(oldLayer, with: gradientLayer)
        
    }
    
    @IBAction func applyLightTheme() {
        
        // Gradient background
        let bottomColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1)
        let topColor = UIColor(red: (65/255.0), green: (66/255.0), blue: (144/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations : [Float] = [0.0, 1.0]
        
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = self.view.bounds
        
        let oldLayer = self.view.layer.sublayers![0]
        self.view.layer.replaceSublayer(oldLayer, with: gradientLayer)
    }
}

