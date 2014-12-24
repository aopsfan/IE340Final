//
//  ElectromagneticForce.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/19/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class System {
    let members: [Particle]
    var forces = [Force]()
    
    init(members: [Particle]) {
        self.members = members
    }
    
    func runFor(duration: Double) {
        for force in forces { force.cacheActions() }
        
        for particle in members {
            let forceUnits = forces.reduce(UnitOfForce(0, 0)) { (memo, force) in
                let action = force.actionFor(particle)
                let appliedForceUnits = action == nil ? UnitOfForce(0, 0) : action!.force
                return memo + appliedForceUnits
            }
            particle.moveBy(forceUnits, duration: duration)
        }
    }
}