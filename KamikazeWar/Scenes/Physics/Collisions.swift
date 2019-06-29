//
//  Collisions.swift
//  PlaneDetection
//
//  Created by Alberto García-Muñoz on 22/06/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

struct Collisions: OptionSet {
    let rawValue: Int
    
    static let plane = Collisions(rawValue: 1 << 0)
    static let bullet = Collisions(rawValue: 1 << 1)
    
}
