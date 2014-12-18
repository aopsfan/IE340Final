//
//  CompositeDrawing.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/17/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class CompositeDrawing: Drawing {
    var particleDrawings: [ParticleDrawing]
    
    init(particleDrawings: [ParticleDrawing]) {
        self.particleDrawings = particleDrawings
    }
    
    func particles() -> [Particle] {
        return particleDrawings.map({ $0.particle })
    }
    
    func moveBy(force: Force, duration: Double) {
        for drawing in particleDrawings { drawing.moveBy(force, duration: duration) }
    }
    
    func draw(#context: CGContextRef) {
        for drawing in particleDrawings { drawing.draw(context: context) }
    }
}