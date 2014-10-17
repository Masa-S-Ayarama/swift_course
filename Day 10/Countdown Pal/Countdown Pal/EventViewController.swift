//
//  EventViewController.swift
//  Countdown Pal
//
//  Created by Fernando Fernandes on 10/16/14.
//  Copyright (c) 2014 Blue Spell. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    // MARK: iVars
    
    var tapTimerControl = 1
    var backgroundImage: UIImage?
    var eventName: String?
    var eventDate: NSDate?
    var timer: NSTimer?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var timeToEventLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    // MARK: Actions
    
    @IBAction func timeLeftButtonPressed(sender: AnyObject) {
        
        // Tap timer starts in 1 (years)
        // While it holds 1 to 4, alternate between units
        // (years, months, days and hh:mm:ss) as usual
        if (tapTimerControl >= 1 && tapTimerControl <= 3) {
            tapTimerControl++
            displayTimeLeftForEvent()
            
        } else {
            // All units covered
            // Start over
            tapTimerControl = 1
            displayTimeLeftForEvent()
        }
    }
    
    // MARK: Logic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.image = backgroundImage
        eventNameLabel.text = eventName
        timeToEventLabel.text = eventDate?.description
        
        displayTimeLeftForEvent()
    }
    
    // Decides which information to show
    // based on the user input (tap) on
    // the time left view.
    func displayTimeLeftForEvent() {
        switch tapTimerControl {
            case 1:
            displayYearsLeftForEvent()
                
            case 2:
            displayMonthsLeftForEvent()
                
            case 3:
            displayDaysLeftForEvent()
            
            default:
            self.timer = NSTimer .scheduledTimerWithTimeInterval(
                1.0,
                target: self,
                selector: Selector("displayHoursLeftForEvent"),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    // Years left
    func displayYearsLeftForEvent() {
        invalidateTimer()
        let dateComponents = calculateDifferenceBetweenDatesWithUnit(NSCalendarUnit.YearCalendarUnit)
        timeToEventLabel.text = String("\(dateComponents.year) years")
    }
    
    // Months left
    func displayMonthsLeftForEvent() {
        invalidateTimer()
        let dateComponentes = calculateDifferenceBetweenDatesWithUnit(NSCalendarUnit.MonthCalendarUnit)
        timeToEventLabel.text = String("\(dateComponentes.month) months")
    }
    
    
    // Days left
    func displayDaysLeftForEvent() {
        invalidateTimer()
        let dateComponents = calculateDifferenceBetweenDatesWithUnit(NSCalendarUnit.DayCalendarUnit)
        timeToEventLabel.text = String("\(dateComponents.day) days")
    }
    
    // Hours left (in fact hh:mm:ss)
    func displayHoursLeftForEvent() {
        let duration = eventDate!.timeIntervalSinceDate(NSDate())
        
        let hours = floor(duration / 60 / 60);
        let minutes = floor((duration - (hours * 60 * 60)) / 60);
        let seconds = floor(duration - (hours * 60 * 60) - (minutes * 60));
        
        timeToEventLabel.text =
            String(format: "%02d:", Int(hours)) +
            String(format: "%02d:", Int(minutes)) +
            String(format: "%02d", Int(seconds))
    }
    
    // MARK: Helpers
    
    // Calculates and returns the difference between two dates
    // considering the unit passed in as argument (Years, Months, Days)
    func calculateDifferenceBetweenDatesWithUnit(unit: NSCalendarUnit) -> NSDateComponents {
        
        let calendar = NSCalendar.currentCalendar()
        let unitFlags = unit
        
        let dateComponents = calendar.components(
            unitFlags,
            fromDate: NSDate(), // Current date
            toDate: eventDate!,
            options: nil
        )
        
        return dateComponents
    }
    
    func invalidateTimer() {
        timer?.invalidate()
    }
}