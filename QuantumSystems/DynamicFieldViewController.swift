//
//  DynamicFieldViewController.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/17/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

import Cocoa

class DynamicFieldViewController: NSViewController, DynamicFieldViewDelegate {
    var dynamicFieldView: DynamicFieldView { return view as DynamicFieldView }
    var drawing: SystemDrawing!
    var manualForce: ManualForce!
    var refreshesPerSecond = 60.0
    var frameRate: Double { return 1.0 / refreshesPerSecond }
    
    let directionalUnitOfForces: [ArrowKeyCode: UnitOfForce] = [
        .Left: UnitOfForce(-1e5, 0),
        .Right: UnitOfForce(1e5, 0),
        .Up: UnitOfForce(0, -1e5),
        .Down: UnitOfForce(0, 1e5)
        ]
    
    func standardSystem() -> System {
        let clockCenter = Point(Double(view.frame.width / 2), Double(view.frame.height / 2))
        let clockRadius = Double(view.frame.height * 2 / 5)
        var hourPoints = [Point]()
        
        for hour in 1...12 {
            let theta = Double(hour) * M_PI * 2 / 12 + M_PI / 12
            hourPoints.append(Point(clockRadius * cos(theta) + clockCenter.x, clockRadius * sin(theta) + clockCenter.y))
        }
        
        var systemMembers: [Particle] = hourPoints.map { Particle(stationaryConductorWithCharge: 3, location: $0) }
        let leftCenter = Point(Double(view.frame.width * 2 / 5), Double(view.frame.height / 2))
        let rightCenter = Point(Double(view.frame.width * 3 / 5), Double(view.frame.height / 2))
        
        let particle = Particle(mass: 35, charge: 1)
        particle.location = clockCenter
        systemMembers.append(particle)
        
        let system = System(members: systemMembers)
        let electromagneticForce = ElectromagneticForce()
        manualForce = ManualForce(controlledParticle: particle)
        
        electromagneticForce.applyToSystem(system)
        manualForce.applyToSystem(system)
        
        return system
    }
    
    func pendulumSystem() -> System {
        let center = Point(Double(view.frame.width / 2), Double(view.frame.height / 2))
        let topLeft = Point(center.x - 200.0, center.y + 50.0)
        let bottomLeft = Point(center.x - 200.0, center.y - 50.0)
        let topRight = Point(center.x + 200.0, center.y + 50.0)
        let bottomRight = Point(center.x + 200.0, center.y - 50.0)
        
        var members = [topLeft, bottomLeft, topRight, bottomRight].map {
            Particle(stationaryConductorWithCharge: 10, location: $0)
        }
        
        let middleRight = Point(center.x + 175.0, center.y)
        let particle = Particle(mass: 100, charge: 1, location: middleRight, speed: 0, angle: 0)
        
        members.append(particle)
        let system = EstimatedSystem(members: members)
        ElectromagneticForce().applyToSystem(system)
        
        return system
    }
    
    func orbitSystem() -> System {
        let center = Point(Double(view.frame.width / 2), Double(view.frame.height / 2))
        let orbitStart = Point(center.x - 200, center.y)
        let startingVelocity = 800.0
        
        let star = Particle(stationaryConductorWithCharge: -5, location: center)
        let planet = Particle(mass: 35, charge: 1, location: orbitStart, speed: startingVelocity, angle: 90)
        
        let system = EstimatedSystem(members: [star, planet])
        ElectromagneticForce().applyToSystem(system)
        
        return system
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawing = SystemDrawing(system: pendulumSystem())
        
        dynamicFieldView.delegate = self
    }
    
    func draw(view: DynamicFieldView, context: CGContextRef) {
        drawing.runFor(frameRate)
        drawing.draw(context: context)
    }
    
    func dynamicFieldViewDidDraw(view: DynamicFieldView) {
        dispatch_async(dispatch_get_main_queue(), {
            view.setNeedsDisplayInRect(view.bounds)
        })
    }
    
    func arrowKeyDown(code: ArrowKeyCode, inView view: DynamicFieldView) {
        manualForce.inputtedForce = manualForce.inputtedForce + directionalUnitOfForces[code]!
    }
    
    func arrowKeyUp(code: ArrowKeyCode, inView view: DynamicFieldView) {
        manualForce.inputtedForce = manualForce.inputtedForce - directionalUnitOfForces[code]!
    }
}
