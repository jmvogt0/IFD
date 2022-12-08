//
//  deviceRotation.swift
//  TreeHeight
//
//  Created by Jan Vogt on 05.12.22.
//
import CoreMotion

struct Gyro {
    class Gyros {
        var motionManager = CMMotionManager()
        var rotation :Double = 0
        func startGyros() {
            print("startGyro")
            if self.motionManager.isDeviceMotionAvailable == true {
                    
                self.motionManager.deviceMotionUpdateInterval = 0.5
                    
                let queue = OperationQueue()
                self.motionManager.startDeviceMotionUpdates(to: queue, withHandler: { motion, error in
                        
                    // Get the attitude of the device
                    if let attitude = motion?.attitude {
                        // Get the pitch (in radians) and rotate
                        self.rotation = Double.pi / 2 - attitude.pitch
                        DispatchQueue.main.async {
                            // Update some UI
                        }
                    }
                        
                })
                    
                print("Device motion started")
            }else {
                print("Device motion unavailable")
            }
        }

        func stopGyros() {
            print("stop Gyros")
            self.motionManager.stopDeviceMotionUpdates()
            
        }
    }
}
