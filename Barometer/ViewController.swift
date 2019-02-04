//
//  ViewController.swift
//  Barometer
//
//  Created by James Baughman on 2/2/19.
//  Copyright © 2019 James Baughman. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    lazy var altimeter = CMAltimeter() // Lazily load CMAltimeter
    @IBOutlet weak var myAltitudePressureMetric: UILabel?
    @IBOutlet weak var myAltitudePressureFeet: UILabel?
    @IBOutlet weak var myPressurehPa: UILabel?
    @IBOutlet weak var altLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAltimiter()
    }
    
    func startAltimiter() {
        if (CMAltimeter.isRelativeAltitudeAvailable()) {
            if CMAltimeter.isRelativeAltitudeAvailable() {
                altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main) { (data, error) in
                    self.myAltitudePressureMetric?.text = String.init(format: "%.1fM", (data?.relativeAltitude.floatValue)!)
                    self.myAltitudePressureFeet?.text = String.init(format: "%.1fft", (data?.relativeAltitude.floatValue)! * 3.6)
                    self.myPressurehPa?.text = String.init(format: "%.2f hPA", (data?.pressure.floatValue)!*10)
                    let altitude = data!.relativeAltitude.floatValue    // Relative altitude in meters
                    self.altLabel!.text = String(format: "%.02f", altitude)
                }
            } else {
                myAltitudePressureFeet?.text = " no pressure data"
                myAltitudePressureMetric?.text = " no pressure data"
            }
        }
        
    }


}

