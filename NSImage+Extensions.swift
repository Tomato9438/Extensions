//
//  NSImage + Extensions.swift
//  TextCandy 2
//
//  Created by Tom Bluewater on 11/14/16.
//  Copyright © 2016 Tom Bluewater. All rights reserved.
//

import Foundation
import Cocoa
import AVFoundation

extension NSImage {
    enum HEICError: Error {
        case heicNotSupported
        case cgImageMissing
        case couldNotFinalize
    }
    
    func resize(w: CGFloat, h: CGFloat) -> NSImage {
        let image = self.copy() as! NSImage
        let destSize = NSMakeSize(w, h)
        let newImage = NSImage(size: destSize)
        newImage.lockFocus()
        image.draw(in: NSMakeRect(0, 0, destSize.width, destSize.height), from: NSMakeRect(0, 0, image.size.width, image.size.height), operation: .sourceOver, fraction: CGFloat(1))
        newImage.unlockFocus()
        newImage.size = destSize
        return NSImage(data: newImage.tiffRepresentation!)!
    }
    
    func resizeWidth(side: CGFloat) -> NSImage {
        let image = self.copy() as! NSImage
        var newSize = CGSize()
        if image.size.width > image.size.height {
            let widRatio = image.size.width / side
            let newHeight = image.size.height / widRatio
            newSize = CGSize(width: side, height: newHeight)
        } else {
            let heiRatio = image.size.height / side
            let newWidth = image.size.width / heiRatio
            newSize = CGSize(width: newWidth, height: side)
        }
        let newImage = NSImage(size: newSize)
        newImage.lockFocus()
        image.draw(in: NSMakeRect(0, 0, newSize.width, newSize.height), from: NSMakeRect(0, 0, image.size.width, image.size.height), operation: .sourceOver, fraction: CGFloat(1))
        newImage.unlockFocus()
        newImage.size = newSize
        return NSImage(data: newImage.tiffRepresentation!)!
    }
    
    func scale(factor: CGFloat) -> NSImage {
        let image = self.copy() as! NSImage
        let destSize = NSMakeSize(image.size.width * factor, image.size.height * factor)
        let newImage = NSImage(size: destSize)
        newImage.lockFocus()
        image.draw(in: NSMakeRect(0, 0, destSize.width, destSize.height), from: NSMakeRect(0, 0, image.size.width, image.size.height), operation: .sourceOver, fraction: CGFloat(1))
        newImage.unlockFocus()
        newImage.size = destSize
        return NSImage(data: newImage.tiffRepresentation!)!
    }
    
    func resolutionsAdjusted(dpi: CGFloat) -> NSImage? {
        let image = self.copy() as! NSImage
        if let data = image.tiffRepresentation {
            if let bitmapImageRep = NSBitmapImageRep(data: data) {
                //let pointsSize = bitmapImageRep.size
                let pixelSize = CGSize(width: bitmapImageRep.pixelsWide, height: bitmapImageRep.pixelsHigh)
                let updatedPointsSize = CGSize(width: ceil(72.0 * pixelSize.width)/dpi, height: ceil(72.0 * pixelSize.height)/dpi)
                bitmapImageRep.size = updatedPointsSize
                let newData = bitmapImageRep.representation(using: .tiff, properties: [:])
                return NSImage(data: newData!)
            }
            else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func getImageResolutions() -> CGSize? {
        let image = self.copy() as! NSImage
        if let data = image.tiffRepresentation {
            if let bitmapImageRep = NSBitmapImageRep(data: data) {
                let pointsSize = bitmapImageRep.size
                let pixelSize = CGSize(width: bitmapImageRep.pixelsWide, height: bitmapImageRep.pixelsHigh)
                return CGSize(width: 72.0/(pointsSize.width/pixelSize.width), height: 72.0/(pointsSize.height/pixelSize.height))
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    func flipImage(dir: Int) -> NSImage {
        // http-//qiita.com/hanamiju/items/8a265d473a3bbbde32e4
        let image = self.copy() as! NSImage
        let flipper = NSAffineTransform()
        let dimensions = image.size
        let newImage = NSImage(size: image.size)
        newImage.lockFocus()
        
        if dir == 0 {
            // horizontally //
            flipper.scaleX(by: -1, yBy: 1)
            flipper.concat()
            image.draw(at: NSPoint(x: -dimensions.width, y: 0), from: NSMakeRect(0,0, dimensions.width, dimensions.height), operation: .copy, fraction: 1)
        }
        else if dir == 1 {
            // vertically //
            flipper.scaleX(by: 1, yBy: -1)
            flipper.concat()
            image.draw(at: NSPoint(x: 0, y: -dimensions.height), from: NSMakeRect(0,0, dimensions.width, dimensions.height), operation: .copy, fraction: 1)
        }
        else {
            // both //
            flipper.scaleX(by: -1, yBy: -1)
            flipper.concat()
            image.draw(at: NSPoint(x: -dimensions.width, y: -dimensions.height), from: NSMakeRect(0,0, dimensions.width, dimensions.height), operation: .copy, fraction: 1)
        }
        
        newImage.unlockFocus()
        return NSImage(data: newImage.tiffRepresentation!)!
    }
    
    func rotateImage(degrees: CGFloat) -> NSImage {
        var imageBounds = NSZeroRect
        imageBounds.size = self.size
        let pathBounds = NSBezierPath(rect: imageBounds)
        var transform = NSAffineTransform()
        transform.rotate(byDegrees: degrees)
        pathBounds.transform(using: transform as AffineTransform)
        let rotatedBounds: NSRect = NSMakeRect(NSZeroPoint.x, NSZeroPoint.y , self.size.width, self.size.height )
        let rotatedImage = NSImage(size: rotatedBounds.size)
        
        //Center the image within the rotated bounds
        imageBounds.origin.x = NSMidX(rotatedBounds) - (NSWidth(imageBounds) / 2)
        imageBounds.origin.y  = NSMidY(rotatedBounds) - (NSHeight(imageBounds) / 2)
        
        // Start a new transform
        transform = NSAffineTransform()
        // Move coordinate system to the center (since we want to rotate around the center)
        transform.translateX(by: +(NSWidth(rotatedBounds) / 2 ), yBy: +(NSHeight(rotatedBounds) / 2))
        transform.rotate(byDegrees: degrees)
        // Move the coordinate system bak to normal
        transform.translateX(by: -(NSWidth(rotatedBounds) / 2 ), yBy: -(NSHeight(rotatedBounds) / 2))
        // Draw the original image, rotated, into the new image
        rotatedImage.lockFocus()
        transform.concat()
        self.draw(in: imageBounds, from: NSZeroRect, operation: .copy, fraction: 1.0)
        rotatedImage.unlockFocus()
        return rotatedImage
    }
    
    func roundCorners(withRadius radius: CGFloat) -> NSImage {
        // https;//gist.github.com/jeanetienne/76ee42335f80c09d6dafc58169c669fe
        let rect = NSRect(origin: NSPoint.zero, size: size)
        if
            let cgImage = self.makeCGImage(),
            let context = CGContext(data: nil,
                                    width: Int(size.width),
                                    height: Int(size.height),
                                    bitsPerComponent: 8,
                                    bytesPerRow: 4 * Int(size.width),
                                    space: CGColorSpaceCreateDeviceRGB(),
                                    bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue) {
            context.beginPath()
            context.addPath(CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil))
            context.closePath()
            context.clip()
            context.draw(cgImage, in: rect)
            
            if let composedImage = context.makeImage() {
                return NSImage(cgImage: composedImage, size: size)
            }
        }
        return self
    }
    
    func addNoAlpha() -> NSImage {
        let image = self.copy() as! NSImage
        let newImage = NSImage(size: image.size)
        newImage.lockFocus()
        NSColor.white.set()
        CGRect(origin: CGPoint.zero, size: newImage.size).fill()
        image.draw(at: CGPoint.zero, from: CGRect(origin: CGPoint.zero, size: image.size), operation: .copy, fraction: 1)
        newImage.unlockFocus()
        return NSImage(data: newImage.imageJPEGRepresentation)!
    }
    
    func makeCGImage() -> CGImage? {
        // https://stackoverflow.com/questions/24595908/swift-nsimage-to-cgimage
        let image = self.copy() as! NSImage
        var imageRect: CGRect = CGRect(origin: NSZeroPoint, size: image.size)
        return image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)
    }
    
    func getPixelColor(point: CGPoint) -> NSColor? {
        // https://stackoverflow.com/questions/25146557/how-do-i-get-the-color-of-a-pixel-in-a-uiimage-with-swift
        if let cgImage = self.makeCGImage() {
            if let dataProvider = cgImage.dataProvider {
                if let pixelData = dataProvider.data {
                    let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
                    let pixelInfo: Int = ((Int(self.size.width) * Int(point.y)) + Int(point.x)) * 4
                    let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
                    let g = CGFloat(data[pixelInfo + 1]) / CGFloat(255.0)
                    let b = CGFloat(data[pixelInfo + 2]) / CGFloat(255.0)
                    let a = CGFloat(data[pixelInfo + 3]) / CGFloat(255.0)
                    return NSColor(deviceRed: r, green: g, blue: b, alpha: a)
                }
            }
        }
        return nil
    }
    
    func heicData(compressionQuality: CGFloat) throws -> Data {
        let data = NSMutableData()
        guard let imageDestination = CGImageDestinationCreateWithData(data, AVFileType.heic as CFString, 1, nil) else {
            throw HEICError.heicNotSupported
        }
        
        guard let cgImage = self.makeCGImage() else {
            throw HEICError.cgImageMissing
        }
        
        let options: NSDictionary = [kCGImageDestinationLossyCompressionQuality: compressionQuality]
        CGImageDestinationAddImage(imageDestination, cgImage, options)
        guard CGImageDestinationFinalize(imageDestination) else {
            throw HEICError.couldNotFinalize
        }
        
        return data as Data
    }
    
    static func makeColorImage(color: NSColor, size: NSSize) -> NSImage {
        /* it will not work with translucent colors */
        let image = NSImage.init(size: size)
        image.lockFocus()
        color.drawSwatch(in: NSRect(origin: .zero, size: size))
        image.unlockFocus()
        return image
    }
    
    var imageBMPRepresentation: Data {
        return NSBitmapImageRep(data: tiffRepresentation!)!.representation(using: .bmp, properties: [:])!
    }
    var imageGIFRepresentation: Data {
        return NSBitmapImageRep(data: tiffRepresentation!)!.representation(using: .gif, properties: [:])!
    }
    var imageJPEGRepresentation: Data {
        return NSBitmapImageRep(data: tiffRepresentation!)!.representation(using: .jpeg, properties: [:])!
    }
    var imageJP2Representation: Data {
        return NSBitmapImageRep(data: tiffRepresentation!)!.representation(using: .jpeg2000, properties: [:])!
    }
    var imagePNGRepresentation: Data {
        return NSBitmapImageRep(data: tiffRepresentation!)!.representation(using: .png, properties: [:])!
    }
    var imageTIFFRepresentation: Data {
        return NSBitmapImageRep(data: tiffRepresentation!)!.representation(using: .tiff, properties: [:])!
    }
}

