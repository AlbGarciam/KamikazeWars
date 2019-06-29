//
//  LandingViewController.swift
//  KamikazeWar
//
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    var viewModel: LandingViewModel!
    
    //MARK: - UIComponents
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton! {
        didSet {
            startButton.addTarget(self, action: #selector(onStartButtonTapped), for: .touchUpInside)
        }
    }
    
    //MARK: - UI Initialization
    
    init() {
        super.init(nibName: nil, bundle: Bundle.init(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewReady()
    }
    
    //MARK: - UI private methods
    @objc private func onStartButtonTapped() {
        viewModel.onStartRequested()
    }
}

//MARK: - ViewModel communication
protocol LandingViewControllerProtocol: class {
    func updateScore(_ value: Int)
}

extension LandingViewController: LandingViewControllerProtocol {
    func updateScore(_ value: Int) {
        scoreLabel.text = "HighScore: \(value)"
    }
}
