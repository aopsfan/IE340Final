//
//  Velocity.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/13/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class Velocity: Vector { // distance / duration
    func momentumFor(#mass: Double) -> Vector { // mass * distance / duration
        return self * mass
    }
    
    func distanceAfter(#duration: Double) -> Vector { // distance
        return self * duration
    }
}

func +(left: Velocity, right: Velocity) -> Velocity {
    return Velocity(left.x + right.x, left.y + right.y)
}

func -(left: Velocity, right: Velocity) -> Velocity {
    return Velocity(left.x - right.x, left.y - right.y)
}

func *(left: Velocity, right: Double) -> Velocity {
    return Velocity(left.x * right, left.y * right)
}

func /(left: Velocity, right: Double) -> Velocity {
    return Velocity(left.x / right, left.y / right)
}