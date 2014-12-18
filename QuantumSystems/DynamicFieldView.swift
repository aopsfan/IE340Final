//
//  DynamicFieldView.swift
//  QuantumSystems
//
//  Created by Bruce Ricketts on 12/17/14.
//  Copyright (c) 2014 fireypotato. All rights reserved.
//

// for bitmap contexts, see https://developer.apple.com/library/mac/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_context/dq_context.html

import Cocoa

protocol DynamicFieldViewDelegate {
    func draw(view: DynamicFieldView, context: CGContextRef)
    func dynamicFieldViewDidDraw(view: DynamicFieldView)
    func arrowKeyDown(code: ArrowKeyCode, inView view: DynamicFieldView)
    func arrowKeyUp(code: ArrowKeyCode, inView view: DynamicFieldView)
}

enum ArrowKeyCode: UInt16 {
    case Left = 123
    case Right = 124
    case Down = 125
    case Up = 126
}

class DynamicFieldView: NSView {
    override var flipped: Bool { return true }
    override var acceptsFirstResponder: Bool { return true }
    var delegate: DynamicFieldViewDelegate!
    var keysDown: [ArrowKeyCode] = []
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        let context = NSGraphicsContext.currentContext()!.CGContext
        CGContextClearRect(context, dirtyRect)
        
        delegate.draw(self, context: context)
        delegate.dynamicFieldViewDidDraw(self)
    }
    
    override func keyDown(event: NSEvent) {
        let arrowCode = ArrowKeyCode(rawValue: event.keyCode)
        if arrowCode != nil && !contains(keysDown, arrowCode!) {
            delegate.arrowKeyDown(arrowCode!, inView: self)
            keysDown.append(arrowCode!)
        }
    }
    
    override func keyUp(event: NSEvent) {
        let arrowCode = ArrowKeyCode(rawValue: event.keyCode)
        if arrowCode != nil {
            delegate.arrowKeyUp(arrowCode!, inView: self)
            keysDown = keysDown.filter({ $0 != arrowCode! })
        }
    }
}
