//
//  ViewController.swift
//  Magnetic Words
//
//  Created by Fernando Fernandes on 10/10/14.
//  Copyright (c) 2014 Blue Spell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Class Members
    
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var wordsView: UIView!
    
    var wordList: [String]!
    
    // This is OK in an iPhone/portrait
    let numberOfMagneticWordsPerMatch = 25
    
    // I'm starting at 900 for "safety"
    // (so no other view with tag < 900 will be removed from the UI)
    // Probably there are safer ways
    let tagStartingNumber = 900
    
    // MARK: Logic
    
    override func viewDidLoad() {
        createWordList()
    }
    
    // Gets the list of words from the file "haiku.txt"
    func createWordList() {
        if let path = NSBundle.mainBundle().pathForResource("haiku", ofType: "txt") {
            var err: NSError? = NSError()
            if let rawList = String.stringWithContentsOfFile(path, encoding: NSUTF8StringEncoding, error: &err) {
                wordList = rawList.componentsSeparatedByString(" ")
            }
        }
    }
    
    @IBAction func newWordsPressed(sender: AnyObject) {
        // Remove magnetic words from UI
        removeMagneticWords()
        
        // For word variety, shuffle the word list
        wordList.shuffle(wordList.count)
        
        for i in 0...numberOfMagneticWordsPerMatch {
            
            // Create a magnetic word
            var magneticWord = createMagneticWord(wordList[i])
            
            // Tag it for later removal
            magneticWord.tag = i + tagStartingNumber
            
            // Set its centers
            defineMagneticWordsCenter(magneticWord)
            
            // Add it to the view
            view.addSubview(magneticWord)
        }
    }
    
    // Creates magnetic words
    func createMagneticWord(word: String) -> UILabel! {
        let magneticWord = UILabel()
        
        // Style and text
        magneticWord.backgroundColor = UIColor.whiteColor()
        magneticWord.text = word
        magneticWord.textAlignment = NSTextAlignment.Center
        
        // Size
        magneticWord.sizeToFit()
        // (I wanted some white space around the word)
        var rect = magneticWord.frame
        rect = CGRectInset(rect, -4, 0)
        magneticWord.frame = rect
        
        /*
         Now I got a little crazy and decided to add
         some black lines at the bottom and at the right
         of the magnetic so it would give it a subtle 3D effect
        */
        
        // At bottom
        let lineBottom = UIView(frame: CGRectMake(0, magneticWord.frame.height, magneticWord.frame.width, 1))
        lineBottom.backgroundColor = UIColor.blackColor()
        
        // At right
        let lineRight = UIView(frame: CGRectMake(magneticWord.frame.width, 0, 1, CGFloat(magneticWord.frame.height + 1)))
        lineRight.backgroundColor = UIColor.blackColor()
        
        // Add them!
        magneticWord.addSubview(lineBottom)
        magneticWord.addSubview(lineRight)

        
        // Gesture recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("handlePanGesture:"))
        magneticWord.addGestureRecognizer(panGesture)
        magneticWord.userInteractionEnabled = true
        
        return magneticWord
    }
    
    // Defines the center of the  magnetic words
    // I'm limiting their center below the "magnetic board"
    // (that grey square in the UI)
    // This way users can have a fell that they are snaping
    // the words on the magnetic board. Kind of. :P
    func defineMagneticWordsCenter(magneticWord: UILabel) {
        
        // Values for "x"
        let mininum_x = wordsView.frame.origin.x // E.g.: 0.0
        let maximum_x = wordsView.frame.width // E.g.: 288
        let randomX = randomNumberBetween(UInt32(mininum_x), max: UInt32(maximum_x))
        
        // Values for "y"
        // (The "+ 30" is to compensate some white space at the top of my UI)
        let mininum_y = wordsView.frame.origin.y + 30 // E.g.: 374
        let maximum_y = wordsView.frame.origin.y + CGFloat(wordsView.frame.height) // E.g.: vertical space from 374 (Y origin) to its height
        let randomY = randomNumberBetween(UInt32(mininum_y), max: UInt32(maximum_y))
        
        // Set the center of the magnetic word
        magneticWord.center = CGPoint(x: CGFloat(randomX), y: CGFloat(randomY))
    }
    
    // Remove all magnetic words from the UI
    func removeMagneticWords() {
        for i in 0...numberOfMagneticWordsPerMatch {
            if let magneticWord = view.viewWithTag(i + tagStartingNumber) {
                magneticWord.removeFromSuperview()
            }
        }
    }
    
    // MARK: Helpers
    
    // Returns a random number between a minimum and a maximum number
    // The return of this function can INCLUDE the minimum and the maximum
    // Long story: http://bit.ly/generateRandomNumbersBetweenTwoNumbers
    func randomNumberBetween(min: UInt32, max: UInt32) -> UInt32! {
        return UInt32(min) + arc4random_uniform(UInt32(max) - UInt32(min) + 1)
    }
    
    func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translationInView(view)
        panGesture.setTranslation(CGPointZero, inView: view)
        
        let magneticWord = panGesture.view as UILabel
        magneticWord.center = CGPoint(x: magneticWord.center.x + translation.x, y: magneticWord.center.y + translation.y)
        
        if panGesture.state == UIGestureRecognizerState.Ended {
            // 1
            let velocity = panGesture.velocityInView(view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            println("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
            
            // 2
            let slideFactor = 0.1 * slideMultiplier     //Increase for more of a slide
            // 3
            var finalPoint = CGPoint(x:panGesture.view!.center.x + (velocity.x * slideFactor),
                y:panGesture.view!.center.y + (velocity.y * slideFactor))
            // 4
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            
            // 5
            UIView.animateWithDuration(Double(slideFactor * 2),
                delay: 0,
                // 6
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: {panGesture.view!.center = finalPoint },
                completion: nil)
        }
    }
}

// MARK: Extensions

/*
 Randomizes the order of an array's elements.
 Source: http://bit.ly/shuffleArraySwiftExtension

 The 'sort' function needs a closure to order elements.
 This closure takes two parameters (elem1, elem2) and returns:

  - true if the first value should appear before the second value
  - false otherwise

 If instead we return a random boolean then we just mix up the whole thing :)
 Explanation source: http://bit.ly/howToShuffleSwiftArrray
*/
extension Array {
    mutating func shuffle(elements: Int!) {
        for _ in 0..<elements {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}