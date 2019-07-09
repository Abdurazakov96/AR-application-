//
//  ViewController.swift
//  AR (application)
//
//  Created by Магомед Абдуразаков on 07/07/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let scene = SCNScene()
        
        guard let surface = loadModel(name: "Courtyard.scnassets/Surface.scn") else {return}
        scene.rootNode.addChildNode(surface)
        
        guard let dragon = loadModel(name: "Courtyard.scnassets/Dragon 2.5_dae.dae") else {
            return
        }
        scene.rootNode.addChildNode(dragon)
        
        let chair = createChair()
        chair.position = SCNVector3(x: 1.25, y: -0.24, z: -2.5)
        scene.rootNode.addChildNode(chair)
        
        let three = createTree()
        three.position = SCNVector3(x:1.25, y: 1.01, z: -5)
        scene.rootNode.addChildNode(three)
        
        let threeSecond = createTree()
        threeSecond.position = SCNVector3(x:-1.25, y: 1.01, z: -5)
        scene.rootNode.addChildNode(threeSecond)
        
        
        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        sceneView.session.pause()
    }
    
    func loadModel(name: String) -> SCNNode? {
        guard let scene = SCNScene(named: name) else {return nil}
        let node = scene.rootNode.clone()
        
        return node
    }
    
    func createChair () -> SCNNode{
        let chair = SCNBox(width: 0.5, height: 0.5, length: 1, chamferRadius: 0)
        let color = UIImage(named: "Courtyard.scnassets/chairTexture.jpg")!
        let material = SCNMaterial()
        material.diffuse.contents = color
        chair.materials = [material]
        
        let thing = SCNNode(geometry: chair)
        
        return thing
        
    }
    
    func createTree () -> SCNNode {
        
        let stall = SCNCylinder(radius: 0.2, height: 3)
        stall.firstMaterial?.diffuse.contents = UIColor.brown
        let node = SCNNode(geometry: stall)
        
        let sphere = SCNSphere(radius: 1)
        sphere.firstMaterial?.diffuse.contents = UIColor.green
        let createSphere = SCNNode(geometry: sphere)
        createSphere.position.y = 1
       
        node.addChildNode(createSphere)
        
        return node
        
    }
}

