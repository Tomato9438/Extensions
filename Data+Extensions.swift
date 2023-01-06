//
//  Array+Extensions.swift
//  AddMeBaby
//
//  Created by Tom Bluewater on 4/30/17.
//  Copyright © 2017 Tom Bluewater. All rights reserved.
//

import Cocoa

extension Data {
    var string: String? { return String(data: self, encoding: .utf8) }
}

