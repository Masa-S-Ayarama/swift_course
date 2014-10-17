//
//  ViewController.swift
//  Countdown Pal
//
//  Created by Fernando Fernandes on 10/16/14.
//  Copyright (c) 2014 Blue Spell. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
    // MARK: Actions
    
    @IBAction func goButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("Show Camera", sender: self)
    }
    
    // MARK: Segue Stuff
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        let cameraViewController = segue?.destinationViewController as CameraViewController
        cameraViewController.eventName = eventNameTextField.text
        cameraViewController.eventDate = eventDatePicker.date
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        eventNameTextField.resignFirstResponder()
        return false
    }
}