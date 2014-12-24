//
//  Force.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/22/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Foundation

protocol Force {
    init(system: System)
    func cacheActions()
    func actionFor(particle: Particle) -> Action?
}