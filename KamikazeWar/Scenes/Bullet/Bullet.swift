//
//  Bullet.swift
//  PlaneDetection
//
//  Created by Alberto García-Muñoz on 22/06/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import ARKit

class Bullet: SCNNode {
    
    let speed: Float = 12
    
    init(_ camera: ARCamera) {
        super.init()
        let bullet = createTexture()
        addPhysics(to: bullet)
        addInitialVelocity(from: camera)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTexture() -> SCNGeometry {
        let bullet = SCNSphere(radius: 0.015)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        bullet.materials = [material]
        geometry = bullet
        return bullet
    }
    
    private func addPhysics(to node: SCNGeometry) {
        let shape = SCNPhysicsShape(geometry: node, options: nil)
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        physicsBody?.isAffectedByGravity = true
        physicsBody?.categoryBitMask = Collisions.bullet.rawValue
        physicsBody?.contactTestBitMask = Collisions.plane.rawValue
    }
    
    private func addInitialVelocity(from camera: ARCamera) {
        let matrix = SCNMatrix4(camera.transform)
        let v = -speed
        let dir = SCNVector3(v * matrix.m31, v * matrix.m32, v * matrix.m33)
        let pos = SCNVector3(matrix.m41, matrix.m42, matrix.m43)
        
        physicsBody?.applyForce(dir, asImpulse: true)
        position = pos
    }
}
