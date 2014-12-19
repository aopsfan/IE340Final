//
//  UnitOfForce.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/13/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class UnitOfForce: Vector { // mass * distance / (duration * duration)
    func accelerationFor(#mass: Double) -> UnitOfAcceleration { // distance / (duration * duration)
        return UnitOfAcceleration(r: r() / mass, theta: theta())
    }
}

func +(left: UnitOfForce, right: UnitOfForce) -> UnitOfForce {
    return UnitOfForce(left.x + right.x, left.y + right.y)
}

func -(left: UnitOfForce, right: UnitOfForce) -> UnitOfForce {
    return UnitOfForce(left.x - right.x, left.y - right.y)
}

func *(left: UnitOfForce, right: Double) -> UnitOfForce {
    return UnitOfForce(left.x * right, left.y * right)
}

func /(left: UnitOfForce, right: Double) -> UnitOfForce {
    return UnitOfForce(left.x / right, left.y / right)
}