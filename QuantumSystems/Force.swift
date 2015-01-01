//
//  Force.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/22/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

protocol Force {
    func applyToSystem(system: System)
    func calculateActions()
    func actionFor(particle: Particle) -> Action?
    func duplicate() -> Force
}