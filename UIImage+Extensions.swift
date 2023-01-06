//
//  UIImage+Extensions.swift
//  ExtensionsTest
//
//  Created by Tom Bluewater on 12/18/16.
//  Copyright © 2016 Tom Bluewater. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func resize(w: CGFloat, h: CGFloat) -> UIImage {
        // Source: http;//stackoverflow.com/questions/31314412/how-to-resize-image-in-swift
        let image = self.copy() as! UIImage
        let targetSize = CGSize(width: w, height: h)
        let size = image.size
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func imageScaled(scale: CGFloat) -> UIImage {
        let image = self.copy() as! UIImage
        let targetSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let size = image.size
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func scaledToSize(size: CGSize) -> UIImage {
        let image = self.copy() as! UIImage
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    static func stroke(diameter: CGFloat, weight: CGFloat, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let ctx = UIGraphicsGetCurrentContext()
        ctx!.saveGState()
        
        let offset = diameter-weight
        let rect = CGRect(x: weight/2.0, y: weight/2.0, width: offset, height: offset)
        //CGContextSetFillColorWithColor(ctx, UIColor.clearColor().CGColor)
        //CGContextFillEllipseInRect(ctx, rect)
        
        ctx!.setStrokeColor(color.cgColor)
        ctx!.setLineWidth(weight)
        ctx!.strokeEllipse(in: rect)
        ctx!.restoreGState()
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }
    
    static func makeColorImage(color: UIColor, size: CGSize) -> UIImage {
        // Source: http;//stackoverflow.com/questions/26542035/create-uiimage-with-solid-color-in-swift
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func overlayTwoImages(backImage: UIImage, topImage: UIImage) -> UIImage {
        let dif = CGPoint.init(x: (backImage.size.width - topImage.size.width)/2.0, y: (backImage.size.height - topImage.size.height)/2.0)
        UIGraphicsBeginImageContextWithOptions(backImage.size, false, 0.0)
        backImage.draw(in: CGRect.init(origin: CGPoint.zero, size: backImage.size))
        topImage.draw(in: CGRect.init(x: dif.x, y: dif.y, width: topImage.size.width, height: topImage.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    static func makeGradientImage(rect: CGRect, topColor: UIColor, bottomColor: UIColor) -> UIImage {
        // Source: http;//stackoverflow.com/questions/38592351/ios-draw-gradient-swift/38593430#38593430
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = rect
        UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        gradientLayer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func tinted(color: UIColor) -> UIImage {
        // Source: https;//stackoverflow.com/questions/48744415/how-to-set-tint-color-of-an-image
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        context!.setBlendMode(CGBlendMode.colorBurn)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context!.draw(self.cgImage!, in: rect)
        context!.setBlendMode(CGBlendMode.sourceIn)
        context!.addRect(rect)
        context!.drawPath(using: CGPathDrawingMode.fill)
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return coloredImage!
    }
}

