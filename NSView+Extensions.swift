//
//  NSView+Extensions.swift
//  Desk Shots 3
//
//  Created by Kimberly on 6/2/18.
//  Copyright © 2018 Kimberly. All rights reserved.
//

import Cocoa

extension NSView {
    // https://stackoverflow.com/questions/41386423/get-image-from-calayer-or-nsview-swift-3
    func getImageFromView() -> NSImage? {
        let imageRepresentation = bitmapImageRepForCachingDisplay(in: bounds)!
        cacheDisplay(in: bounds, to: imageRepresentation)
        if let cgImage = imageRepresentation.cgImage {
            return NSImage(cgImage: cgImage, size: bounds.size)
        } else {
            return nil
        }
    }
}

