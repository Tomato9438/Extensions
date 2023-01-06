//
//  Array+Extensions.swift
//  AddMeBaby
//
//  Created by Tom Bluewater on 4/30/17.
//  Copyright © 2017 Tom Bluewater. All rights reserved.
//

import Foundation

extension Array {
    // http-//qiita.com/codelynx/items/4c5c6c2faf8315c208fe
    func shuffled() -> Array<Element> {
        var array = self
        
        for i in 0..<array.count {
            let ub = UInt32(array.count - i)
            let d = Int(arc4random_uniform(ub))
            
            let tmp = array[i]
            array[i] = array[i+d]
            array[i+d] = tmp
        }
        
        return array
    }
}

