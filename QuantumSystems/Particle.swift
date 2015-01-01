//
//  Particle.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/9/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class Particle: Equatable {
    var location = Point(0, 0)
    var velocity = UnitOfVelocity(0, 0)
    let mass: Double
    let charge: Double
    private var stationary: Bool
    private var stationaryConductorMassMultiplier = 100.0
    
    init(mass: Double, charge: Double) {
        self.mass = mass
        self.charge = charge
        self.stationary = false
    }
    
    init(stationaryConductorWithCharge charge: Double, location: Point) {
        self.mass = abs(charge) * stationaryConductorMassMultiplier
        self.charge = charge
        self.location = location
        self.stationary = true
    }
    
    convenience init(mass: Double, charge: Double, location: Point, speed: Double, angle: Double) {
        self.init(mass: mass, charge: charge)
        self.location = location
        self.velocity = UnitOfVelocity(r: speed, theta: angle * M_PI / 180.0)
    }
    
    func moveBy(force: UnitOfForce, duration: Double) {
        if stationary { return }
        
        let acceleration = force.accelerationFor(mass: mass)
        location = location + velocity.distanceAfter(duration: duration) + acceleration.distanceAfter(duration: duration)
        velocity = velocity + acceleration.velocityAfter(duration: duration)
    }
    
    func momentum() -> Vector {
        return velocity * mass
    }
    
    func duplicate() -> Particle {
        let particle = Particle(mass: mass, charge: charge)
        particle.location = location
        particle.velocity = velocity
        particle.stationary = stationary
        
        return particle
    }
}

func ==(left: Particle, right: Particle) -> Bool {
    return left === right
}