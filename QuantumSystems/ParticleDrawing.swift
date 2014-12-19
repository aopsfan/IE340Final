//
//  ParticleDrawing.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/16/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Cocoa

class ParticleDrawing: Drawing {
    let particle: Particle
    let color: NSColor
    
    init(_ particle: Particle, color: NSColor) {
        self.particle = particle
        self.color = color
    }
    
    func draw(#context: CGContextRef) {
        let center = CGPointMake(CGFloat(particle.location.x), CGFloat(particle.location.y))
        let radius = CGFloat(particle.mass)
        
        CGContextBeginPath(context)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextAddArc(context, center.x, center.y, radius, CGFloat(0.0), CGFloat(2 * M_PI), 0)
        CGContextFillPath(context)
    }
    
    func moveBy(force: UnitOfForce, duration: Double) {
        particle.moveBy(force, duration: duration)
    }
}