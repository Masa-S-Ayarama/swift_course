//
//  CameraViewController.swift
//  Countdown Pal
//
//  Created by Fernando Fernandes on 10/16/14.
//  Copyright (c) 2014 Blue Spell. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MAKE: iVars
    
    var eventName: String?
    var eventDate: NSDate?
    let imagePicker = UIImagePickerController()
    var backgroundImage: UIImage?
    
    // MAKE: Logic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check if there is a valid image
        // (user my be getting back from the camera)
        if (backgroundImage?.CGImage == nil && backgroundImage?.CIImage == nil) {
            
            // No valid image, present the camera view
            presentViewController(imagePicker, animated: true, completion: nil)
            
        } else {
            // Image is valid, present the event view
            performSegueWithIdentifier("Show Event", sender: self)
        }
    }
    
    // MAKE: Segue Stuff
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        let eventViewController = segue?.destinationViewController as EventViewController
        eventViewController.backgroundImage = backgroundImage
        eventViewController.eventName = eventName
        eventViewController.eventDate = eventDate
    }
    
    // MAKE: Image Picker Controller Delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        backgroundImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Not implemented in this exercise
    }
}
