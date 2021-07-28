//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Andrew Yuan on 7/20/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var Tip1Label: UITextField!
    @IBOutlet weak var Tip2Label: UITextField!
    @IBOutlet weak var Tip3Label: UITextField!
    @IBOutlet weak var DarkModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let tip1 = defaults.string(forKey: "tip1") ?? "15%"
        let tip2 = defaults.string(forKey: "tip2") ?? "18%"
        let tip3 = defaults.string(forKey: "tip3") ?? "20%"
        
        Tip1Label.text = tip1
        Tip2Label.text = tip2
        Tip3Label.text = tip3
        
        if self.traitCollection.userInterfaceStyle == .dark {
            DarkModeSwitch.setOn(true, animated: false)
        } else {
            DarkModeSwitch.setOn(false, animated: false)
        }
    }
    
    @IBAction func DarkModeToggle(_ sender: Any) {
        if (DarkModeSwitch.isOn){
            self.view.window!.overrideUserInterfaceStyle = .dark
        }
        else {
            self.view.window!.overrideUserInterfaceStyle = .light
        }
    }
    
    @IBAction func Tip1EditComplete(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.set(Tip1Label.text, forKey: "tip1")
        defaults.synchronize()
    }
    
    
    @IBAction func Tip2EditComplete(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.set(Tip2Label.text, forKey: "tip2")
        defaults.synchronize()
    }
    
    @IBAction func Tip3EditComplete(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.set(Tip3Label.text, forKey: "tip3")
        defaults.synchronize()
    }

}
