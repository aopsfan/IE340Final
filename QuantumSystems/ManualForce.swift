//
//  ManualForce.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/23/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class ManualForce: Force {
    let system: System
    var controlledParticle: Particle!
    var inputtedForce = UnitOfForce(0, 0)
    
    required init(system: System) {
        self.system = system
    }
    
    func cacheActions() {}
    
    func actionFor(particle: Particle) -> Action? {
        return particle == controlledParticle ? Action(particle: particle, force: inputtedForce) : nil
    }
}