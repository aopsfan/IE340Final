//
//  Force.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/13/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class Force: Vector { // mass * distance / (duration * duration)
    func accelerationFor(#mass: Double) -> Acceleration { // distance / (duration * duration)
        return Acceleration(r: r() / mass, theta: theta())
    }
}

func +(left: Force, right: Force) -> Force {
    return Force(left.x + right.x, left.y + right.y)
}

func -(left: Force, right: Force) -> Force {
    return Force(left.x - right.x, left.y - right.y)
}

func *(left: Force, right: Double) -> Force {
    return Force(left.x * right, left.y * right)
}

func /(left: Force, right: Double) -> Force {
    return Force(left.x / right, left.y / right)
}