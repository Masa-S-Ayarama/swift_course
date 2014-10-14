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
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    // MARK: IBActions
    @IBAction func guessButtonPressed(sender: AnyObject) {
        if let input = numberTextField.text.toInt() {
            guessedNumber = input
            println("Guessed number is: \(guessedNumber)")
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
        generateNewRandomNumber()
        println("Random number is: \(randomNumber)")
    }
    
    // Compares the user input with the
    // generated random number
    func checkGuess() {
        
        showFeedbackLabel()
        
        if guessedNumber == randomNumber {
            setFeedbackLabelToRightOn()
            
        } else if guessedNumber > randomNumber {
            setFeedbackLabelToHigher()
            
        } else {
            setFeedbackLabelToLower()
        }
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