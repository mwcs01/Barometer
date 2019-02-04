//
//  InterfaceController.swift
//  Barometer Watch Extension
//
//  Created by James Baughman on 2/2/19.
//  Copyright © 2019 James Baughman. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var myAltitudePressureMetric: WKInterfaceLabel!
    
    @IBOutlet weak var myAltitudePressureFeet: WKInterfaceLabel!
    @IBOutlet weak var myPressurehPa: WKInterfaceLabel!
    
    @IBOutlet weak var altLabel: WKInterfaceLabel!
    lazy var altimeter = CMAltimeter() // Lazily load CMAltimeter

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        startAltimiter()
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func startAltimiter() {
            if CMAltimeter.isRelativeAltitudeAvailable() {
                altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main) { (data, error) in
                    self.myAltitudePressureMetric?.setText(String.init(format: "%.1fM", (data?.relativeAltitude.floatValue)!))
                    
                    self.myAltitudePressureFeet?.setText(String.init(format: "%.1fft", (data?.relativeAltitude.floatValue)! * 3.6))
                    
                    self.myPressurehPa?.setText(String.init(format: "%.2f hPA", (data?.pressure.floatValue)!*10))
                    let altitude = data!.relativeAltitude.floatValue    // Relative altitude in meters
                    self.altLabel!.setText(String(format: "%.02f", altitude))
                }
            } else {
                myAltitudePressureFeet?.setText(" no pressure data")
                myAltitudePressureMetric?.setText(" no pressure data")
            }
    }

}
