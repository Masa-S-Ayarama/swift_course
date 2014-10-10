//
//  ViewController.swift
//  Day Two
//
//  Created by Fernando Fernandes on 10/7/14.
//  Copyright (c) 2014 Blue Spell. All rights reserved.
//

import UIKit

// Adds new functionality to Swift's String object
extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)!.doubleValue
    }
}

class ViewController: UIViewController {
    
    // Input
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
   
    // Output
    @IBOutlet weak var areaOutputLabel: UILabel!
    @IBOutlet weak var perimeterOutputLabel: UILabel!
    
    @IBAction func calculateButtonPressed(sender: AnyObject) {
        
        if let width = widthTextField.text.toDouble()
        {
            if let height = heightTextField.text.toDouble()
            {
                // Calculate area
                var area = width * height
                areaOutputLabel.text = "\(area)"
                
                // Calculate perimeter
                var perimeter = 2 * (width + height)
                perimeterOutputLabel.text = "\(perimeter)"
            }
        }
    }
}