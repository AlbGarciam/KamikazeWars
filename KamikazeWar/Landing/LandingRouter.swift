//
//  LandingRouter.swift
//  KamikazeWar
//
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

class LandingRouter {
    
    weak var viewController: LandingViewController?
    
    static func getViewController() -> LandingViewController {
        
        let configuration = configureModule()
        
        return configuration.vc
        
    }
    
    //MARK: - Navigations
    func navigateToARScene() {
        let controller = ARSceneRouter.getViewController()
        viewController?.present(controller, animated: true, completion: nil)
    }
    
    func navigateToError() {
        let title = "Device not supported"
        let subTitle = "This device does not support ARKit"
        let alert = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        viewController?.present(alert, animated: true, completion: nil)
    }
}

//MARK: - MVVM
extension LandingRouter {
    
    private static func configureModule() -> (vc: LandingViewController, vm: LandingViewModel, rt: LandingRouter) {
        
        let viewController = LandingViewController()
        let router = LandingRouter()
        let viewModel = LandingViewModel()
        
        viewController.viewModel = viewModel
        
        viewModel.router = router
        viewModel.view = viewController
        
        router.viewController = viewController
        
        return (viewController, viewModel, router)
        
    }
    
}
