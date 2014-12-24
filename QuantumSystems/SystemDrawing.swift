//
//  SystemDrawing.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/17/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class SystemDrawing: Drawing {
    private var particleDrawings: [ParticleDrawing]
    let system: System
    
    init(system: System) {
        self.system = system
        self.particleDrawings = system.members.map { ParticleDrawing($0) }
    }
    
    func particles() -> [Particle] {
        return particleDrawings.map({ $0.particle })
    }
    
    func runFor(duration: Double) {
        system.runFor(duration)
    }
    
    func draw(#context: CGContextRef) {
        for drawing in particleDrawings { drawing.draw(context: context) }
    }
}