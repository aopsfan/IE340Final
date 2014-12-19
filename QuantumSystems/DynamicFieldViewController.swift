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
    var drawing: Drawing!
    var force = UnitOfForce(0, 0)
    var refreshesPerSecond = 60.0
    var frameRate: Double { return 1.0 / refreshesPerSecond }
    
    let directionalUnitOfForces: [ArrowKeyCode: UnitOfForce] = [
        .Left: UnitOfForce(-2500, 0),
        .Right: UnitOfForce(2500, 0),
        .Up: UnitOfForce(0, -2500),
        .Down: UnitOfForce(0, 2500)
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lightParticle = Particle(mass: 10, charge: 0)
        lightParticle.location = Point(50, 50)
        let lightDrawing = ParticleDrawing(lightParticle, color: NSColor.redColor())
        
        let heavyParticle = Particle(mass: 20, charge: 0)
        heavyParticle.location = Point(100, 200)
        let heavyDrawing = ParticleDrawing(heavyParticle, color: NSColor.blueColor())
        
        let massiveParticle = Particle(mass: 75, charge: 0)
        massiveParticle.location = Point(500, 500)
        let massiveDrawing = ParticleDrawing(massiveParticle, color: NSColor.greenColor())
        
        drawing = CompositeDrawing(particleDrawings: [massiveDrawing, lightDrawing, heavyDrawing])
        
        dynamicFieldView.delegate = self
    }
    
    func draw(view: DynamicFieldView, context: CGContextRef) {
        drawing.moveBy(force, duration: frameRate)
        drawing.draw(context: context)
    }
    
    func dynamicFieldViewDidDraw(view: DynamicFieldView) {
        dispatch_async(dispatch_get_main_queue(), {
            view.setNeedsDisplayInRect(view.bounds)
        })
    }
    
    func arrowKeyDown(code: ArrowKeyCode, inView view: DynamicFieldView) {
        force = force + directionalUnitOfForces[code]!
    }
    
    func arrowKeyUp(code: ArrowKeyCode, inView view: DynamicFieldView) {
        force = force - directionalUnitOfForces[code]!
    }
}
