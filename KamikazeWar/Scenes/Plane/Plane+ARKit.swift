//
//  Plane+ARKit.swift
//  KamikazeWar
//
//  Created by Alberto García-Muñoz on 29/06/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import ARKit

extension Plane {
    func prepareARNode() {
        guard let scene = SCNScene(named: "Plane.scn"),
            let plane = scene.rootNode.childNode(withName: "Plane", recursively: true) else { fatalError("Could not load scene")}
        addChildNode(plane)
        transform.m41 = Float.random(in: -1...1) // X
        transform.m42 = Float.random(in: -1...1) // Y
        transform.m43 = -1 * Float.random(in: 1...1.5) // Z
        // Add Animations
        // Values are meters
        let hoverUp = SCNAction.moveBy(x: 0, y: 0.2, z: 0, duration: 2.5)
        let hoverDown = SCNAction.moveBy(x: 0, y: -0.2, z: 0, duration: 2.5)
        // let rotateSequence = SCNAction.sequence([rotatePi, rotatePi])
        let sequence = SCNAction.sequence([hoverUp, hoverDown])
        let loop = SCNAction.repeatForever(sequence)
        runAction(loop)
        
        let shape = SCNPhysicsShape(geometry: SCNBox(width: 0.67, height: 0.17, length: 0.4, chamferRadius: 0), options: nil)
        physicsBody = SCNPhysicsBody(type: .static, shape: shape)
        physicsBody?.isAffectedByGravity = false
        
        physicsBody?.collisionBitMask = Collisions.bullet.rawValue
        physicsBody?.categoryBitMask = Collisions.plane.rawValue
    }
    
    func addHealthBar() {
        healthBox = SCNBox(width: initialHealthLentgh, height: 0.02, length: 0.02, chamferRadius: 0)
        
        let rectangleMaterial = SCNMaterial()
        rectangleMaterial.diffuse.contents = UIColor.green
        healthBox.materials = [rectangleMaterial]
        
        healthNode = SCNNode(geometry: healthBox)
        addChildNode(healthNode)
        healthNode.position = SCNVector3Make(0, 0.2, 0)
        
    }
    
    private func moveToCamera() {
        let move = SCNAction.move(to: SCNVector3.init(0, 0, 0), duration: 4)
        runAction(move) {
            
        }
    }
    
    func face(to cameraOrientation: simd_float4x4) {
        
        var transform = cameraOrientation
        transform.columns.3.x = position.x
        transform.columns.3.y = position.y
        transform.columns.3.z = position.z
        
        self.transform = SCNMatrix4(transform)
        
    }
}
