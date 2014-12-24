//
//  Reaction.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/19/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class Action {
    let particle: Particle
    let force: UnitOfForce
    
    init(particle: Particle, force: UnitOfForce) {
        self.particle = particle
        self.force = force
    }
    
    func reaction(onParticle particle: Particle) -> Action {
        return Action(particle: particle, force: force.oppositeForce())
    }
    
    func runFor(duration: Double) {
        particle.moveBy(force, duration: duration)
    }
}