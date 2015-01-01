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
    var system: System!
    private var allActions = [Action]()
    
    init() {}
    
    func applyToSystem(system: System) {
        self.system = system
        system.addForce(self)
    }
    
    func calculateActions() {
        allActions = []
        
        let particles = self.system.members
        let indexes = particles.map { find(particles, $0)! }
        
        for index1 in indexes {
            for index2 in indexes.filter({ $0 > index1 }) {
                for action in actionsFor(particles[index1], particles[index2]) {
                    allActions.append(action)
                }
            }
        }
    }
    
    func actionFor(particle: Particle) -> Action? {
        let actions = allActions.filter({ $0.particle === particle })
        if actions.count == 0 { return nil }
        return actions.reduce(Action(particle: particle, force: UnitOfForce(0, 0))) { (memo, action) in
            return Action(particle: particle, force: memo.force + action.force)
        }
    }
    
    func duplicate() -> Force {
        return ElectromagneticForce()
    }
    
    private func actionsFor(part1: Particle, _ part2: Particle) -> [Action] {
        let r21 = Vector(part1.location.x - part2.location.x, part1.location.y - part2.location.y) // part2 -> part1
        let r21Length = r21.r()
        let vectorPart = r21.unitVector() * electromagneticConstant
        
        let numerator = part1.charge * part2.charge
        let denominator = abs(r21Length * r21Length)
        let scalarPart = numerator / denominator
        
        let forceOnPart1 = UnitOfForce(r: vectorPart.r() * scalarPart, theta: vectorPart.theta())
        let actionForPart1 = Action(particle: part1, force: forceOnPart1)
        
        return [actionForPart1, actionForPart1.reaction(onParticle: part2)]
    }
}