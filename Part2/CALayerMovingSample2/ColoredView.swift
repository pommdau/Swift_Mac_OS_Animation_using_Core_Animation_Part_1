//
//  ColoredView.swift
//  CALayerMovingSample2
//
//  Created by HIROKI IKEUCHI on 2020/01/17.
//  Copyright © 2020年 hikeuchi. All rights reserved.
//

import Cocoa

class ColoredView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSColor.magenta.setFill()
        NSBezierPath(rect: self.bounds).fill()
    }
    
}
