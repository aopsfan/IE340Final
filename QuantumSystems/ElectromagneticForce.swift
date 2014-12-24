//
//  ElectromagneticForce.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/22/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

let electromagneticConstant = 8.9875517873681764e8 // Coulomb's constant (divided by ten)

class ElectromagneticForce: Force {
    let system: System
    private var allActions = [Action]()
    
    required init(system: System) {
        self.system = system
    }
    
    func cacheActions() {
        allActions = []
        
        let particles = self.system.members
        let indexes = particles.map { find(particles, $0)! }
        
        for index1 in indexes {
            for index2 in indexes.filter({ $0 > index1 }) {
                for action in self.actionsFor(particles[index1], particles[index2]) {
                    allActions.append(action)
                }
            }
        }
    }
    
    func actionFor(particle: Particle) -> Action? {
        let actions = allActions.filter({ $0.particle === particle })
        return actions.reduce(Action(particle: particle, force: UnitOfForce(0, 0))) { (memo, action) in
            return Action(particle: particle, force: memo.force + action.force)
        }
    }
    
    private func actionsFor(part1: Particle, _ part2: Particle) -> [Action] {
        let r21 = Vector(part1.location.x - part2.location.x, part1.location.y - part2.location.y) // part2 -> part1
        let r21Length = max(r21.r(), 5.0) // TALK ABOUT THIS IN YOUR PAPER YA NASTY
        let vectorPart = r21.unitVector() * electromagneticConstant
        
        let numerator = part1.charge * part2.charge
        let denominator = abs(r21Length * r21Length)
        let scalarPart = numerator / denominator
        
        let forceOnPart1 = UnitOfForce(r: vectorPart.r() * scalarPart, theta: vectorPart.theta())
        let action = Action(particle: part1, force: forceOnPart1)
        return [action, action.reaction(onParticle: part2)]
    }
}