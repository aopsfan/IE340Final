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
    
    init(_ particle: Particle) {
        self.particle = particle
        
        var color: NSColor!
        if particle.charge < 0 { // RARE if-else statement from Bruce Ricketts
            color = NSColor.blueColor()
        } else if particle.charge == 0 {
            color = NSColor.whiteColor()
        } else if particle.charge > 0 {
            color = NSColor.redColor()
        }
        
        self.color = color
    }
    
    func draw(#context: CGContextRef) {
        let center = CGPointMake(CGFloat(particle.location.x), CGFloat(particle.location.y))
        let radius = sqrt(CGFloat(particle.mass))
        
        CGContextBeginPath(context)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextAddArc(context, center.x, center.y, radius, CGFloat(0.0), CGFloat(2 * M_PI), 0)
        CGContextFillPath(context)
    }
    
    func moveBy(force: UnitOfForce, duration: Double) {
        particle.moveBy(force, duration: duration)
    }
}