//
//  Explossion.swift
//  PlaneDetection
//
//  Created by Alberto García-Muñoz on 22/06/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import ARKit

class Explossion: SCNNode {
    
    static func show(with node: SCNNode, in scene: SCNScene) {
        guard let explossion = SCNParticleSystem(named: "Explossion", inDirectory: nil) else { return }
        let p = node.position
        let translationMatrix = SCNMatrix4MakeTranslation(p.x, p.y, p.z)
        let r = node.rotation
        let rotationMatrix = SCNMatrix4MakeRotation(r.w, r.x, r.y, r.z)
        
        let transformMatrix = SCNMatrix4Mult(translationMatrix, rotationMatrix)
        explossion.emitterShape = node.geometry
        explossion.particleSize = 0.05
        scene.addParticleSystem(explossion, transform: transformMatrix)
    }
    
}
