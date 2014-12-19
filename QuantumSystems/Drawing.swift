//
//  Drawing.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/16/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Cocoa

protocol Drawing {
    func draw(#context: CGContextRef)
    func moveBy(force: UnitOfForce, duration: Double)
}