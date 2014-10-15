//
//  ViewController.swift
//  Number Guessing Game
//
//  Created by Fernando Fernandes on 10/13/14.
//  Copyright (c) 2014 Blue Spell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Class members
    var randomNumber: Int!
    
    // Maximum value for generated random numbers
    let randomNumberMax = 10
    
    // The number typed by the user
    var guessedNumber: Int!
    
    // Field for input the guessed number
    @IBOutlet weak var numberTextField: UITextField!
    
    // Label that provides feedback for the user:
    // Higher, lower or rigth on!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    // MARK: IBActions
    @IBAction func guessButtonPressed(sender: AnyObject) {
        
        // First check if the field has a number
        if let input = numberTextField.text.toInt() {
            guessedNumber = input
            
            // Debug purposes
            println("Guessed number is: \(guessedNumber)")
            
            // Verify if the numbers match
            checkGuess()
        }
    }
    
    @IBAction func resetButtonPressed(sender: AnyObject) {
        hideFeedbackLabel()
        clearFeedbackLabelText()
        clearNumberTextField()
        generateNewRandomNumber()
    }
    
    // MARK: Logic
    override func viewDidLoad() {
        
        // Generates a random number at startup
        generateNewRandomNumber()
        
        // Debug purposes
        println("Random number is: \(randomNumber)")
    }
    
    // Compares the user input with the
    // generated random number
    func checkGuess() {
        
        if guessedNumber == randomNumber {
            setFeedbackLabelToRightOn()
            
        } else if guessedNumber > randomNumber {
            setFeedbackLabelToHigher()
            
        } else {
            setFeedbackLabelToLower()
        }
        
        // The feedback label starts hidden
        showFeedbackLabel()
    }
    
    // MARK: Helpers
    func generateNewRandomNumber() {
        randomNumber = generateRandomNumber(randomNumberMax)
    }
    
    func generateRandomNumber(upTo: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upTo)))
    }
    
    func setFeedbackLabelToHigher() {
        feedbackLabel.text = "Higher"
    }
    
    func setFeedbackLabelToLower() {
        feedbackLabel.text = "Lower"
    }
    
    func setFeedbackLabelToRightOn() {
        feedbackLabel.text = "Right on!"
    }
    
    func hideFeedbackLabel() {
        feedbackLabel.hidden = true
    }
    
    func showFeedbackLabel() {
        feedbackLabel.hidden = false
    }
    
    func clearFeedbackLabelText() {
        feedbackLabel.text = ""
    }
    
    func clearNumberTextField() {
        numberTextField.text = ""
    }
}