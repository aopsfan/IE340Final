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
        
        let leftCenter = Point(Double(view.frame.width * 2 / 5), Double(view.frame.height / 2))
        let rightCenter = Point(Double(view.frame.width * 3 / 5), Double(view.frame.height / 2))
        
        let positiveParticle = Particle(mass: 100, charge: 1);  positiveParticle.location = leftCenter
        let negativeParticle = Particle(mass: 100, charge: -1); negativeParticle.location = rightCenter
        
        let system = System(members: [positiveParticle, negativeParticle])
        manualForce = ManualForce(system: system)
        manualForce.controlledParticle = positiveParticle
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
