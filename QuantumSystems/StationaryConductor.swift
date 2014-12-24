//
//  StationaryConductor.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/23/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

class StationaryConductor: Particle {
    let massMultiplier = 100.0
    
    init(charge: Double) {
        super.init(mass: massMultiplier * abs(charge), charge: charge)
    }
    
    override func moveBy(force: UnitOfForce, duration: Double) {
        // do nothing, the poor guy can't move :(
    }
}