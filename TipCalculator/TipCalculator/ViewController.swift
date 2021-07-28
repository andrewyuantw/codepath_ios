//
//  ViewController.swift
//  TipCalculator
//
//  Created by Andrew Yuan on 7/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var peopleTextField: UITextField!
    @IBOutlet weak var amountPerPersonLabel: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
        appDelegate.myViewController = self
    }
    
    var tip1numPercentage = 0.0
    var tip2numPercentage = 0.0
    var tip3numPercentage = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        
        let tip1 = defaults.string(forKey: "tip1") ?? "15%"
        let tip2 = defaults.string(forKey: "tip2") ?? "18%"
        let tip3 = defaults.string(forKey: "tip3") ?? "20%"
        
        let time = defaults.object(forKey: "lastClosedTime") as? Date
        let lastBill = defaults.string(forKey: "lastClosedBill") ?? ""
        
        if (time == nil){
            billAmountTextField.text = ""
        } else if (NSDate.now.timeIntervalSince(time!) > 600){
            billAmountTextField.text = ""
        } else {
            billAmountTextField.text = lastBill
        }
        
        billAmountTextField.text = lastBill
        
        let index1 = tip1.index(tip1.endIndex, offsetBy: -1)
        let tip1num:Int? = Int(tip1[..<index1])
        let index2 = tip2.index(tip2.endIndex, offsetBy: -1)
        let tip2num:Int? = Int(tip2[..<index2])
        let index3 = tip3.index(tip3.endIndex, offsetBy: -1)
        let tip3num:Int? = Int(tip3[..<index3])
        
        tip1numPercentage = Double(tip1num!) / 100
        tip2numPercentage = Double(tip2num!) / 100
        tip3numPercentage = Double(tip3num!) / 100
        
        tipControl.setTitle(tip1, forSegmentAt: 0)
        tipControl.setTitle(tip2, forSegmentAt: 1)
        tipControl.setTitle(tip3, forSegmentAt: 2)
        
        billAmountTextField.becomeFirstResponder()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveBillAmount()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let tipPercentages = [tip1numPercentage, tip2numPercentage, tip3numPercentage]
        let bill = Double(billAmountTextField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        
        let tipNSNumber = NSNumber(value: tip)
        tipAmountLabel.text = fmt.string(from: tipNSNumber)
        tipAmountDropDown()
        
        let totalNSNumber = NSNumber(value: total)
        totalLabel.text = fmt.string(from: totalNSNumber)
        totalDropDown()
        
        let numPeople = Double(peopleTextField.text!) ?? 1
        let amountPerPerson = NSNumber(value: total/numPeople)
        
        amountPerPersonLabel.text = fmt.string(from: amountPerPerson)
        amountPerPersonDropDown()
    }
    
    func saveBillAmount(){
        let defaults = UserDefaults.standard
        defaults.set(billAmountTextField.text!, forKey: "lastClosedBill")
        defaults.synchronize()
    }
    
    @IBAction func peopleChanged(_ sender: Any) {
        
        let tipPercentages = [tip1numPercentage, tip2numPercentage, tip3numPercentage]
        let bill = Double(billAmountTextField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        
        let numPeople = Double(peopleTextField.text!) ?? 1
        let amountPerPerson = NSNumber(value: total/numPeople)
        
        amountPerPersonLabel.text = fmt.string(from: amountPerPerson)
        amountPerPersonDropDown()
    }
    
    func tipAmountDropDown(){
        tipAmountLabel.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: -50.0);
        UIView.animate(withDuration: 0.3) {
            self.tipAmountLabel.transform = CGAffineTransform.identity;
                }
    }
    
    func totalDropDown(){
        totalLabel.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: -30.0);
        UIView.animate(withDuration: 0.3) {
            self.totalLabel.transform = CGAffineTransform.identity;
                }
    }

    func amountPerPersonDropDown(){
        amountPerPersonLabel.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: -30.0);
        UIView.animate(withDuration: 0.3) {
            self.amountPerPersonLabel.transform = CGAffineTransform.identity;
                }
    }
    

}

