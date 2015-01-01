//
//  ManualForce.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/23/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class ManualForce: Force {
    var controlledParticle: Particle
    var inputtedForce = UnitOfForce(0, 0)
    
    init(controlledParticle: Particle) {
        self.controlledParticle = controlledParticle
    }
    
    func applyToSystem(system: System) {
        system.addForce(self)
    }
    
    func calculateActions() {}
    
    func actionFor(particle: Particle) -> Action? {
        return particle == controlledParticle ? Action(particle: particle, force: inputtedForce) : nil
    }
    
    func duplicate() -> Force {
        return ManualForce(controlledParticle: controlledParticle)
    }
}