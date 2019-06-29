//
//  ARSceneViewController.swift
//  KamikazeWar
//
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit
import ARKit

class ARSceneViewController: UIViewController {
    
    var viewModel: ARSceneViewModel!
    
    //MARK: - UIComponents
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var ammo1xButton: UIButton! {
        didSet {
            ammo1xButton.addTarget(self, action: #selector(on1XAmmoTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var ammo2xButton: UIButton! {
        didSet {
            ammo2xButton.addTarget(self, action: #selector(on2XAmmoTapped), for: .touchUpInside)
        }
    }
    
    //MARK: - Private attributes
    private var plane: Plane?
    
    //MARK: - UI Initialization
    init() {
        super.init(nibName: nil, bundle: Bundle.init(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTracking()
        
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self
        
        // sceneView.showsStatistics = true
        
        // configureLights()
        
        addNewPlane()
        
        // This will prevent to lock the screen
        // If device is set to battery safe, this wont affect.
        // Only available on audio, video, maps and videogames
        UIApplication.shared.isIdleTimerDisabled = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(didTap(_:)))
        sceneView.addGestureRecognizer(tap)
        viewModel.viewIsReady()
    }
    
    //MARK: - UI private methods
    private func startTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    private func pauseTracking() {
        sceneView.session.pause()
    }
    
    
    private func configureLights() {
        sceneView.automaticallyUpdatesLighting = true
        sceneView.autoenablesDefaultLighting = true
    }
    
    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        guard viewModel.canThrowBullet() else { return }
        guard let camera = sceneView.session.currentFrame?.camera else { return }
        let bullet = Bullet(camera)
        sceneView.prepare([bullet]) { [weak self] _ in
            self?.sceneView.scene.rootNode.addChildNode(bullet)
        }
    }
    
    @objc private func on1XAmmoTapped() {
        viewModel.normalAmmoRequested()
    }
    
    @objc private func on2XAmmoTapped() {
        viewModel.poweredAmmoRequested()
    }
}

//MARK: - ViewModel communication
protocol ARSceneViewControllerProtocol: class {
    func addNewPlane()
    func updatePoweredAmmo(_ remaining: Int)
}

extension ARSceneViewController: ARSceneViewControllerProtocol {
    func addNewPlane() {
        let plane = Plane()
        sceneView.prepare([plane]) { [weak self] _ in
            self?.plane = plane
            self?.sceneView.scene.rootNode.addChildNode(plane)
        }
    }
    
    func updatePoweredAmmo(_ remaining: Int) {
        ammo2xButton.setTitle("\(remaining) 2x", for: .normal)
    }
}

extension ARSceneViewController: ARSessionDelegate, ARSCNViewDelegate {
    
    func sessionInterruptionEnded(_ session: ARSession) {
        startTracking()
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        startTracking()
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
        guard let cameraOrientation = session.currentFrame?.camera.transform else { return }
        plane?.face(to: cameraOrientation)
    }
    
}

// Collissions

extension ARSceneViewController: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        let n1 = contact.nodeA
        let n2 = contact.nodeB
        
        let plane = (n1 is Plane ? n1 : n2) as! Plane
        let bullet = (n1 is Bullet ? n1 : n2) as! Bullet
        
        plane.health -= CGFloat(viewModel.hitDammage)
        bullet.removeFromParentNode()
        
        if plane.health <= 0 {
            sceneView.scene.rootNode.childNodes.forEach { $0.removeFromParentNode() }
            Explossion.show(with: plane, in: sceneView.scene)
            viewModel.planeDestroyed()
        }
        
    }
    
}
