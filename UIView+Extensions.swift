//
//  UIView+Extensions.swift
//  aClocks
//
//  Created by Tom Bluewater on 1/7/17.
//  Copyright © 2017 Tom Bluewater. All rights reserved.
//

import UIKit

extension UIView {
    /*
    func startRotate(dur: CFTimeInterval) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = NSNumber(value: .pi * 2)
        rotation.duration = dur
        rotation.isCumulative = true
        rotation.repeatCount = Float(FP_INFINITE)
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func stopRotate() {
        self.layer.removeAnimation(forKey: "rotationAnimation")
    }
    */
    func rotateInfinite(dur: CFTimeInterval) {
        let start = 0.0
        let end = start + 2.0 * .pi
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.duration = dur
        rotateAnimation.repeatCount = .infinity
        rotateAnimation.fromValue = start
        rotateAnimation.toValue = end
        //rotateAnimation.removedOnCompletion = true;
        rotateAnimation.fillMode = CAMediaTimingFillMode.forwards;
        rotateAnimation.autoreverses = false
        rotateAnimation.isCumulative = true // toValue を累計に　: NOにするとカクカクするだけで回らない。
        self.layer.add(rotateAnimation, forKey: "rotationAnimation")
    }
    
    func makeShadow(cRadius: CGFloat, sColor: UIColor, oSize: CGSize, sOpacity: Float, sRadius: CGFloat) {
        layer.cornerRadius = cRadius
        layer.masksToBounds = false
        layer.shadowColor = sColor.cgColor
        layer.shadowOffset = oSize
        layer.shadowOpacity = sOpacity
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowRadius = sRadius
    }
    
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
