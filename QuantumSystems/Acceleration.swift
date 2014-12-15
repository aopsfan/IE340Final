//
//  Acceleration.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/14/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class Acceleration: Vector { // distance / (duration * duration)
    func distanceAfter(#duration: Double) -> Vector { // distance
        return self * (duration * duration / 2.0)
    }
    
    func velocityAfter(#duration: Double) -> Velocity { // distance / duration
        return Velocity(r: r() * duration, theta: theta())
    }
}

func +(left: Acceleration, right: Acceleration) -> Acceleration {
    return Acceleration(left.x + right.x, left.y + right.y)
}

func -(left: Acceleration, right: Acceleration) -> Acceleration {
    return Acceleration(left.x - right.x, left.y - right.y)
}

func *(left: Acceleration, right: Double) -> Acceleration {
    return Acceleration(left.x * right, left.y * right)
}

func /(left: Acceleration, right: Double) -> Acceleration {
    return Acceleration(left.x / right, left.y / right)
}