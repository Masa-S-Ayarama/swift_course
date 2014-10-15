//
//  ViewController.swift
//  Turkey Calculator 3000
//
//  Created by Fernando Fernandes on 10/14/14.
//  Copyright (c) 2014 Blue Spell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: iVars
    
    @IBOutlet weak var numberOfPeopleLabel: UILabel! // Number of people: 1 to 50

    @IBOutlet weak var numberOfPeopleSlider: UISlider!
    
    @IBOutlet weak var turkeySizeLabel: UILabel!
    
    @IBOutlet weak var thawTimeLabel: UILabel!
    
    @IBOutlet weak var cookTimeLabel: UILabel!
    
    let thawHoursPerPound: Double = 6
    
    let cookMinutesPerPound: Int = 15
    
    
    // MARK: Logic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func calculateTurkeySize(numberOfPeople: Double) -> Double? {
        return numberOfPeople * 1.5
    }
    
    func calculateThawTime(turkeySize: Double) -> Double? {
        return (thawHoursPerPound * turkeySize) / 24
    }
    
    func calculateCookTime(turkeySize: Double) -> Int? {
        return cookMinutesPerPound * Int(turkeySize)
    }
    
    // MARK: Helpers
    
    // Invoked when users "slide the slider"
    @IBAction func numberOfPeopleSliderDidChanged(sender: AnyObject) {
        updateUI()
    }
    
    // Updates all the UI labels
    func updateUI() {
        updateNumberOfPeopleLabel()
        updateTurkeySizeLabel()
        updateThawTimeLabel()
        updateCookTimeLabel()
    }
    
    // Updates the Number of people label
    func updateNumberOfPeopleLabel() {
        numberOfPeopleLabel.text = sliderValueToString(numberOfPeopleSlider)
    }
    
    // Updates the Turkey size label
    func updateTurkeySizeLabel() {
        if let numberOfPeopleText = numberOfPeopleLabel.text {
            if let numberOfPeopleDouble = stringToDouble(numberOfPeopleText) {
                if let turkeySize = calculateTurkeySize(numberOfPeopleDouble) {
                    turkeySizeLabel.text = doubleToString(turkeySize)
                    turkeySizeLabel.text = appendLbsToString(turkeySizeLabel.text!)
                }
            }
        }
    }
    
    // Updates the Thaw time label
    func updateThawTimeLabel() {
        if let turkeySizeText = turkeySizeLabel.text {
            if let turkeySizeDouble = stringToDouble(turkeySizeText) {
                if let thawTime = calculateThawTime(turkeySizeDouble) {
                    thawTimeLabel.text = doubleToString(thawTime)
                    thawTimeLabel.text = appendDaysToString(thawTimeLabel.text!)
                }
            }
        }
    }
    
    // Updates the Cook time label
    func updateCookTimeLabel() {
        if let turkeySizeText = turkeySizeLabel.text {
            if let turkeySizeDouble = stringToDouble(turkeySizeText) {
                if let cookTime = calculateCookTime(turkeySizeDouble) {
                    cookTimeLabel.text = convertMinutesToHours(cookTime)
                    cookTimeLabel.text = appendHoursToString(cookTimeLabel.text!)
                }
            }
        }
    }
    
    // UISlider.value is originally a Float
    // This function converts the float value to an Int value
    // and finally the Int value to a String value. :-)
    // Returns UISlider.value as a String
    func sliderValueToString(slider: UISlider) -> String? {
        var sliderStringValue: String?
        if let intValue = floatToInt(slider.value) {
            sliderStringValue = intToString(intValue)
        }
        return sliderStringValue
    }
    
    // Converts a Float to an Int and returns it
    func floatToInt(floatValue: Float) -> Int? {
        return Int(floatValue)
    }
    
    // Converts an Int to String and returns it
    func intToString(intValue: Int) -> String? {
        return String(intValue)
    }
    
    // Converts a Double to a String and returns it
    // Input -> Output example: 1.7595 -> 1.75
    func doubleToString(doubleValue: Double) -> String? {
        return String(format: "%.2f", doubleValue)
    }
    
    // Converts a String to Double and returns it
    // Input -> Output example: "7.5 lbs" -> 7.5
    func stringToDouble(string: String) -> Double? {
        let stringWithoutSuffix = string.componentsSeparatedByString(" ")[0]
        return (stringWithoutSuffix as NSString).doubleValue
    }
    
    // Converts minutes into "readable" hours
    // Input -> Output example: 225 -> 3:45
    func convertMinutesToHours(minutes: Int) -> String {
        let hours = minutes / 60
        var minutes = minutes % 60
        
        if minutes == 0 {
            return ("\(hours):00") // To keep the UI consistent
        } else {
            return ("\(hours):\(minutes)")
        }
    }
    
    // Receives a String and adds " lbs" to it
    // Input -> Output example: 1.5 -> 1.5 lbs
    func appendLbsToString(string: String) -> String {
        return string + " lbs"
    }
    
    // Receives a String and adds " days" to it
    // Input -> Output example: 1.5 -> 1.5 days
    func appendDaysToString(string: String) -> String {
        return string + " days"
    }
    
    // Receives a String and adds " hours" to it
    // Input -> Output example: 1.5 -> 1.5 hours
    func appendHoursToString(string: String) -> String {
        return string + " hours"
    }
}
