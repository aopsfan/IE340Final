//
//  Particle.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/9/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class Particle {
    var location = Point(0, 0)
    var velocity = Velocity(0, 0)
    let mass: Double
    let charge: Double
    
    init(mass: Double, charge: Double) {
        self.mass = mass
        self.charge = charge
    }
    
    func moveBy(force: Force, duration: Double) {
        let acceleration = force.accelerationFor(mass: mass)
        location = location + velocity.distanceAfter(duration: duration) + acceleration.distanceAfter(duration: duration)
        velocity = velocity + acceleration.velocityAfter(duration: duration)
    }
    
    func momentum() -> Vector {
        return velocity * mass
    }
}