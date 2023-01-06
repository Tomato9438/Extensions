//
//  Array+Extensions.swift
//  AddMeBaby
//
//  Created by Tom Bluewater on 4/30/17.
//  Copyright © 2017 Tom Bluewater. All rights reserved.
//

import Cocoa

extension CGFloat {
    func degreesIntoRadians() -> CGFloat {
        let pi = CGFloat(Double.pi)
        return pi * self / 180.0
    }
    
    func radiansIntoDegrees() -> CGFloat {
        let pi = CGFloat(Double.pi)
        return self * 180.0 / pi
    }
    
    func isCGFloatInt() -> Bool {
        let isInteger = floor(self) == self
        return isInteger
    }
}

