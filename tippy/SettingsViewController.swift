//
//  SettingsViewController.swift
//  tippy
//
//  Created by Serge Nasr on 2016-09-18.
//  Copyright © 2016 Serge Nasr. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var themeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        themeSwitch.on = defaults.boolForKey("THEME_SWITCH")
    }
    

    @IBAction func themeAction(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(themeSwitch.on, forKey: "THEME_SWITCH")
        defaults.synchronize()
        
        let themeClass = themeSingletonClass.themeInstance
        if (themeSwitch.on == true) {
            themeClass.theme = "LIGHT"
        }
        else {
            themeClass.theme = "DARK"
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
