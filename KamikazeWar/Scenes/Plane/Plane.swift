//
//  Plane.swift
//  PlaneDetection
//
//  Created by Alberto García-Muñoz on 22/06/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import ARKit

class Plane: SCNNode {
    var health: CGFloat = 1 {
        didSet {
            let width = health < 0 ? 0 : health
            healthNode.scale = SCNVector3(width, 1, 1)
        }
    }
    var healthBox: SCNBox!
    var healthNode: SCNNode!
    
    let initialHealthLentgh: CGFloat = 0.1
        
    override init() {
        super.init()
        prepareARNode()
        addHealthBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
