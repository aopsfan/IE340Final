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
    
    func addForce(force: Force) {
        forces.append(force)
    }
    
    func runFor(duration: Double) {
        for force in forces { force.calculateActions() }
        for action in reducedActions() { action.runFor(duration) }
    }
    
    func reducedActions() -> [Action] {
        return members.map { particle in
            return self.forces.reduce(Action(particle: particle, force: UnitOfForce(0, 0))) { (memo, force) in
                let action = force.actionFor(particle)
                let appliedForceUnits = action == nil ? UnitOfForce(0, 0) : action!.force
                return Action(particle: particle, force: memo.force + appliedForceUnits)
            }
        }
    }
}