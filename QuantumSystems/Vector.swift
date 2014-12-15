//
//  Vector.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/9/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class Vector: Point {
    override init(_ x: Double, _ y: Double) {
        super.init(x, y)
    }
    
    convenience init(r: Double, theta: Double) {
        self.init(r * cos(theta), r * sin(theta))
    }
    
    func r() -> Double {
        return sqrt(x * x + y * y)
    }
    
    func theta() -> Double {
        return atan2(y, x)
    }
}

func +(left: Vector, right: Vector) -> Vector {
    return Vector(left.x + right.x, left.y + right.y)
}

func -(left: Vector, right: Vector) -> Vector {
    return Vector(left.x - right.x, left.y - right.y)
}

func *(left: Vector, right: Double) -> Vector {
    return Vector(left.x * right, left.y * right)
}

func /(left: Vector, right: Double) -> Vector {
    return Vector(left.x / right, left.y / right)
}