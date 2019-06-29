//
//  ARSceneViewModel.swift
//  KamikazeWar
//
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation

class ARSceneViewModel {
    
    //MARK: - MVVM
    weak var view: ARSceneViewControllerProtocol?
    var router: ARSceneRouter?
    
    //MARK: - States
    var score: Int = 0
    var poweredAmmo: Int = 5 {
        didSet {
            view?.updatePoweredAmmo(poweredAmmo)
        }
    }
    var is2xSelected: Bool = false
    
    //MARK: - Public methods
    var hitDammage: Float {
        return is2xSelected ? 2*0.34 : 0.34
    }
    
    func planeDestroyed() {
        score += 1
        let currentHighScore = UserDefaults.standard.read(key: "topScore") ?? Score(score: 0)
        if score > currentHighScore.score {
            UserDefaults.standard.write(key: "topScore", value: score)
        }
        view?.addNewPlane()
    }
    
    func poweredAmmoHitted() {
        
    }
    
    func poweredAmmoRequested() {
        is2xSelected = true
    }
    
    func normalAmmoRequested() {
        is2xSelected = false
    }
    
    func canThrowBullet() -> Bool {
        guard is2xSelected else { return true }
        guard poweredAmmo > 0 else { return false}
        poweredAmmo -= 1
        return true
    }
    
    func viewIsReady() {
        view?.updatePoweredAmmo(poweredAmmo)
    }
}

//MARK: - Extensions
