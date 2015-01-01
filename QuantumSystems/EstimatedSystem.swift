//
//  EstimatedSystem.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/31/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class EstimatedSystem: System {
    func calculateActions() {
        for force in forces { force.calculateActions() }
    }
    
    func runAsNormalSystem(forDuration duration: Double) {
        super.runFor(duration)
    }
    
    override func runFor(duration: Double) {
        for force in forces { force.calculateActions() }
        for action in estimatedReducedActions(duration: duration) { action.runFor(duration) }
    }
    
    func estimatedReducedActions(#duration: Double) -> [Action] {
        let dupeSystem = duplicate()
        dupeSystem.runAsNormalSystem(forDuration: duration)
        dupeSystem.calculateActions()
        
        let firstActions = reducedActions()
        let lastActions = dupeSystem.reducedActions()
        var index = 0
        let estimatedActions: [Action] = firstActions.map { firstAction in
            let lastAction = lastActions[index]
            index++
            
            return Action(particle: firstAction.particle, force: (firstAction.force + lastAction.force) / 2)
        }
        
        return estimatedActions
    }
    
    func duplicate() -> EstimatedSystem {
        let system = EstimatedSystem(members: members.map { $0.duplicate() })
        for force in forces { force.duplicate().applyToSystem(system) }
        
        return system
    }
}