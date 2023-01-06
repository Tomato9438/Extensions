//
//  CGSize+Extensions.swift
//  Quick Clip
//
//  Created by Kimberly on 6/19/18.
//  Copyright © 2018 Kimberly. All rights reserved.
//

import Foundation

extension CGSize {
    func half() -> CGSize {
        return CGSize(width: self.width/2.0, height: self.height/2.0)
    }
}

