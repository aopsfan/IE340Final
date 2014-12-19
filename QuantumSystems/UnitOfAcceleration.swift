//
//  UnitOfAcceleration.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/14/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class UnitOfAcceleration: Vector { // distance / (duration * duration)
    func distanceAfter(#duration: Double) -> Vector { // distance
        return self * (duration * duration / 2.0)
    }
    
    func velocityAfter(#duration: Double) -> UnitOfVelocity { // distance / duration
        return UnitOfVelocity(r: r() * duration, theta: theta())
    }
}

func +(left: UnitOfAcceleration, right: UnitOfAcceleration) -> UnitOfAcceleration {
    return UnitOfAcceleration(left.x + right.x, left.y + right.y)
}

func -(left: UnitOfAcceleration, right: UnitOfAcceleration) -> UnitOfAcceleration {
    return UnitOfAcceleration(left.x - right.x, left.y - right.y)
}

func *(left: UnitOfAcceleration, right: Double) -> UnitOfAcceleration {
    return UnitOfAcceleration(left.x * right, left.y * right)
}

func /(left: UnitOfAcceleration, right: Double) -> UnitOfAcceleration {
    return UnitOfAcceleration(left.x / right, left.y / right)
}