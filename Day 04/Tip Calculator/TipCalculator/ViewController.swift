//
//  ViewController.swift
//  TipCalculator
//
//  Created by Fernando Fernandes on 10/9/14.
//  Copyright (c) 2014 Blue Spell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Amount input
    @IBOutlet weak var amountTextField: UITextField!
    
    // Default percentage labels
    @IBOutlet weak var percent10Label: UILabel!
    @IBOutlet weak var percent15Label: UILabel!
    @IBOutlet weak var percent20Label: UILabel!
    
    // Custom lercentage stuff
    @IBOutlet weak var customPercentageSlider: UISlider!
    @IBOutlet weak var customPercentTotalLabel: UILabel!
    @IBOutlet weak var customPercentLabel: UILabel!
    
    // Total
    @IBOutlet weak var total: UILabel!
    
    // Total # of persons
    @IBOutlet weak var personInput: UITextField!

    // Total per person
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    
    override func viewDidLoad() {
        calculateTipButtonPressed(self)
        updateTotals()
    }
    
    // Calculate button was pressed
    @IBAction func calculateTipButtonPressed(sender: AnyObject) {
        percent10Label.text = numberFormatter().stringFromNumber(amountAsDouble() * 0.10)
        percent15Label.text = numberFormatter().stringFromNumber(amountAsDouble() * 0.15)
        percent20Label.text = numberFormatter().stringFromNumber(amountAsDouble() * 0.20)

        customPercentageDidChange(self)
    }
    
    // User did move the slider
    @IBAction func customPercentageDidChange(sender: AnyObject) {
        customPercentLabel.text = "\(sliderValueAsInt())%"
        updateTotals()
    }
    
    func updateTotals() {
        updateCustomPercentageTotal()
        updateTotal()
        updateTotalPerPerson()
    }
    
    func updateCustomPercentageTotal() {
        customPercentTotalLabel.text = numberFormatter().stringFromNumber(amountAsDouble() * sliderValueAsDouble())
    }
    
    func updateTotal() {
        total.text = numberFormatter().stringFromNumber(amountAsDouble() + (amountAsDouble() * sliderValueAsDouble()))
    }
    
    func updateTotalPerPerson() {
        totalPerPersonLabel.text = numberFormatter().stringFromNumber((amountAsDouble() * sliderValueAsDouble() + amountAsDouble()) / personsAsDouble())
    }
    
    // MARK: helper functions
    
    func amountAsDouble() -> Double {
        return (amountTextField.text as NSString).doubleValue
    }
    
    func sliderValueAsInt() -> Int {
        return Int(customPercentageSlider.value)
    }
    
    func sliderValueAsDouble() -> Double {
        return Double(customPercentageSlider.value / 100)
    }
    
    func personsAsDouble() -> Double {
        return (personInput.text as NSString).doubleValue
    }
    
    // Returns a NSNumberFormatter with CurrencyStyle set
    func numberFormatter() -> NSNumberFormatter {
        // Format numbers for currency
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return numberFormatter
    }
}

