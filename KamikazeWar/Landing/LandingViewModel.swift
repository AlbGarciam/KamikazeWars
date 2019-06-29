//
//  LandingViewModel.swift
//  KamikazeWar
//
//  Copyright © 2019 SoundApp. All rights reserved.
//

import Foundation
import ARKit

class LandingViewModel {
    
    //MARK: - MVVM
    weak var view: LandingViewControllerProtocol?
    var router: LandingRouter?
    
    //MARK: - States
    var score: Int = 0 {
        didSet {
            view?.updateScore(score)
        }
    }
    
    //MARK: - Public methods
    func onStartRequested() {
        let isARKitSupported = ARWorldTrackingConfiguration.isSupported
        isARKitSupported ? router?.navigateToARScene() : router?.navigateToError()
    }
    
    func viewReady() {
        getTopScore()
    }
    
    //MARK: - Private methods
    private func getTopScore() {
        let topScore: Score? = UserDefaults.standard.read(key: "topScore")
        score = topScore?.score ?? 0
    }
    
}

//MARK: - Extensions
