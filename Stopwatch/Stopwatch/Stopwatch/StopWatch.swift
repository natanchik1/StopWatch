//
//  ViewController.swift
//  Stopwatch
//
//  Created by user on 21.10.2022.
//

import UIKit

class StopWatch: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var stopWatchLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var lapButton: UIButton!
    
    var stopWatch = Timer()
    var counter: Double = 0.0
    var arrayLap: [String] = []
    var playTimer: Bool = true
    var lapTimer: Bool = true
    
    
    @IBAction func startStopAction(_ sender: UIButton) {
        if playTimer {
            stopWatch = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(tikStopWatch), userInfo: nil, repeats: true)
            lapButton.isEnabled = true
            changeStartStopButton(button: sender, image: "pause.fill", text: "Pause")
            lapTimer = true
        } else {
            stopWatch.invalidate()
            changeStartStopButton(button: sender, image: "play.fill", text: "Start")
            lapTimer = false
            changeLapButton(button: lapButton, image: "trash", text: "Clear")        }
    }
    
    @IBAction func lapAction(_ sender: UIButton) {
        if lapTimer {
            arrayLap.append(stopWatchLabel.text!)
            table.reloadData()
        } else {
            guard playTimer else { return }
            arrayLap.removeAll()
            table.reloadData()
            changeLapButton(button: sender, image: "plus", text: "Lap")
            sender.isEnabled = false
            stopWatchLabel.text = "00:00"
            counter = 0.0
        }
    }
    
    @objc func tikStopWatch() {
        counter += 0.1
        var minutes: String = "\((Int)(counter / 60))"
        if (Int)(counter / 60) < 10 {
            minutes = "0\((Int)(counter / 60))"
        }
        var seconds: String = String(format: "%.1f",
                                     counter.truncatingRemainder(dividingBy: 60))
        if counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        stopWatchLabel.text = minutes + ":" + seconds
    }
    
    func changeStartStopButton(button: UIButton, image: String, text: String) {
        playTimer = !playTimer
        button.setTitle(text, for: <#T##UIControl.State#>)
        button.setImage(UIImage(systemName: image), for: UIControl.State())
    }
    
    func changeLapButton(button: UIButton, image: String, text: String) {
        lapTimer = !lapTimer
        button.setTitle(text, for: <#T##UIControl.State#>)
        button.setImage(UIImage(systemName: image), for: UIControl.State())
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lapCell", for: indexPath) as! TableRow
        
        cell.lapLabel.text = arrayLap[indexPath.row]
        
        return cell
    }
    
}

