//
//  RestTimer.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 12/27/23.
//

import Foundation

protocol TimerOutput: AnyObject {
    func timerDidUpdate(time: String)
    func timerDidFinish()
}

class RestTimer {
    weak var output: TimerOutput?
    var timer: Timer?
    var remainingTime: Int = 90
    
    var isOn: Bool {
        return timer != nil 
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            self?.tick()
        })
    }
    
    private func tick() {
        if remainingTime > 0 {
            remainingTime -= 1
            let timeString = formatTime(seconds: remainingTime)
            output?.timerDidUpdate(time: timeString)
        } else {
            timer?.invalidate()
            timer = nil
            remainingTime = 90
            output?.timerDidFinish()
        }
    }
    
    private func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
