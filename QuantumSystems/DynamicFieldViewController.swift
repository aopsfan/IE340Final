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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let clockCenter = Point(Double(view.frame.width / 2), Double(view.frame.height / 2))
        let clockRadius = Double(view.frame.height * 2 / 5)
        var hourPoints = [Point]()
        
        for hour in 1...12 {
            let theta = Double(hour) * M_PI * 2 / 12
            hourPoints.append(Point(clockRadius * cos(theta) + clockCenter.x, clockRadius * sin(theta) + clockCenter.y))
        }
        
        var systemMembers: [Particle] = hourPoints.map { point in
            let conductor = StationaryConductor(charge: 5)
            conductor.location = point
            
            return conductor
        }
        
        let leftCenter = Point(Double(view.frame.width * 2 / 5), Double(view.frame.height / 2))
        let rightCenter = Point(Double(view.frame.width * 3 / 5), Double(view.frame.height / 2))
        
        let particle = Particle(mass: 100, charge: 1)
        particle.location = clockCenter
        systemMembers.append(particle)
        
        let system = System(members: systemMembers)
        manualForce = ManualForce(system: system)
        manualForce.controlledParticle = particle
        system.forces = [manualForce, ElectromagneticForce(system: system)]
        
        drawing = SystemDrawing(system: system)
        
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
