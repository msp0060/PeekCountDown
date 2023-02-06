//
//  ViewController.swift
//  PeekCountDown
//
//  Created by Shane Peek on 2/5/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    var selectedHours = 0
        var selectedMinutes = 0
        var count = 0
        var timerTwo:Timer = Timer()
        var isTimerRunning = false

        let hours = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        let minutes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
                        11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
                        21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
                        31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
                        41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
                        51, 52, 53, 54, 55, 56, 57, 58, 59]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.dataSource = self
        picker.delegate = self
        picker.setValue(UIColor.white, forKey: "textColor")
        
        startStopButton.setTitle("Start Timer", for: .normal)
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
            let date = Date()

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
            
            let currentTime = dateFormatter.string(from: date)
            
            self.dateTime.text = currentTime

        }
    }

    
    @IBAction func startStopTapped(_ sender: Any) {
        if (isTimerRunning) {
            isTimerRunning = false
            timerTwo.invalidate()
            startStopButton.setTitle("Start Timer", for: .normal)
        }
        else {
            isTimerRunning = true
            startStopButton.setTitle("Stop Music", for: .normal)
            count = (selectedHours * 3600) + (selectedMinutes * 60)
            timerTwo = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }

    }
    
    
    @objc func timerCounter() -> Void {
        
        count = count - 1
        
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timeRemaining.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String {
        var timeString = "Time Remaining "
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }


}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
            case 0:
                return hours.count
            case 1:
                return minutes.count
            default:
                return 0
        }
    }
    
}

extension ViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
            case 0:
                return "\(row) hours"
            case 1:
                return "\(row) min"
            default:
                return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
            case 0:
                selectedHours = hours[row]
            case 1:
                selectedMinutes = minutes[row]
            default:
                selectedHours = 0
        }
                
    }
}

