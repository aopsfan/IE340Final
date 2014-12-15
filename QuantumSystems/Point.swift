//
//  Location.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/9/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class Point: Equatable {
    let x: Double
    let y: Double
    
    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
    
    func stringValue() -> String {
        return "(\(x), \(y))"
    }
}

func ==(left: Point, right: Point) -> Bool {
    let accuracy = 1e-6
    return abs(left.x - right.x) < accuracy && abs(left.y - right.y) < accuracy
}

func +(left: Point, right: Point) -> Point {
    return Point(left.x + right.x, left.y + right.y)
}

func -(left: Point, right: Point) -> Point {
    return Point(left.x - right.x, left.y - right.y)
}