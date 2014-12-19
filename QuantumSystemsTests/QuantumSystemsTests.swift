//
//  QuantumSystemsTests.swift
//  QuantumSystemsTests
//
//  Created by Bruce Ricketts on 12/9/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Cocoa
import XCTest

class QuantumSystemsTests: XCTestCase {
    let particle = Particle(mass: 1, charge: 0)

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMoveRightSingleStep() {
        let timestep = Double(1.0)
        XCTAssertEqual(particle.momentum(), Vector(0, 0))
        XCTAssertEqual(particle.location, Point(0, 0))
        
        particle.moveBy(UnitOfForce(r: 2, theta: 0), duration: timestep)
        XCTAssertEqual(particle.velocity, Vector(2, 0))
        XCTAssertEqual(particle.location, Point(1, 0))
    }
    
    func testMoveRight60Steps() {
        let timestep = Double(1.0/60.0)
        XCTAssertEqual(particle.momentum(), Vector(0, 0))
        XCTAssertEqual(particle.location, Point(0, 0))
        
        for _ in 1...60 {
            particle.moveBy(UnitOfForce(r: 2, theta: 0), duration: timestep)
        }
        
        XCTAssertEqual(particle.velocity, Vector(2, 0))
        XCTAssertEqual(particle.location, Point(1, 0))
    }
}
