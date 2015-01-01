//
//  ElectromagneticForceTests.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/22/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Cocoa
import XCTest

class ElectromagneticForceTests: XCTestCase {
    var particle1: Particle!
    var particle2: Particle!
    var particle3: Particle!
    var system: System!
    var force: ElectromagneticForce!
    
    override func setUp() {
        super.setUp()
        
        particle1 = Particle(mass: 1, charge: 1); particle1.location = Point(0, 0)
        particle2 = Particle(mass: 1, charge: -1); particle2.location = Point(100, 0)
        particle3 = Particle(mass: 1, charge: 0); particle3.location = Point(0, 100)
        
        system = System(members: [particle1, particle2, particle3]) // not testing System
        force = ElectromagneticForce()
        force.applyToSystem(system)
    }

    func testActions() {
        force.calculateActions()
        
        XCTAssertNotNil(force.actionFor(particle1))
        XCTAssertNotNil(force.actionFor(particle2))
        XCTAssertNotNil(force.actionFor(particle3))
        XCTAssertNil(force.actionFor(Particle(mass: 0, charge: 0)))
    }

}
