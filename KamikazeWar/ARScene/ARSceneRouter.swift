//
//  ARSceneRouter.swift
//  KamikazeWar
//
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

class ARSceneRouter {
    
    weak var viewController: ARSceneViewController?
    
    static func getViewController() -> ARSceneViewController {
        
        let configuration = configureModule()
        
        return configuration.vc
        
    }
    
    //MARK: - Navigations
    
}

//MARK: - MVVM
extension ARSceneRouter {
    
    private static func configureModule() -> (vc: ARSceneViewController, vm: ARSceneViewModel, rt: ARSceneRouter) {
        
        let viewController = ARSceneViewController()
        let router = ARSceneRouter()
        let viewModel = ARSceneViewModel()
        
        viewController.viewModel = viewModel
        
        viewModel.router = router
        viewModel.view = viewController
        
        router.viewController = viewController
        
        return (viewController, viewModel, router)
        
    }
    
}
