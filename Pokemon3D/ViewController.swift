//
//  ViewController.swift
//  Pokemon3D
//
//  Created by Jeremy Adam on 14/06/19.
//  Copyright © 2019 Underway. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        configuration.maximumNumberOfTrackedImages = 10
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "PokemonCard", bundle: Bundle.main)
        {
            
            configuration.trackingImages = imageToTrack
            
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            var pokemon = "Eevee_ColladaMax"
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0)
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi/2
            
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "eeve_card" {
                pokemon = "Eevee/Eevee_ColladaMax"
            }
            else if imageAnchor.referenceImage.name == "blaziken_card" {
                pokemon = "Blaziken/BlazikenF_ColladaMax"
            }
            
            if let pokeScene = SCNScene(named: "art.scnassets/" + pokemon + ".scn") {
                
                if let pokeNode = pokeScene.rootNode.childNodes.first {
                    pokeNode.eulerAngles.x = .pi/2
                    planeNode.addChildNode(pokeNode)
                }
                
            }
            
        }
        
        return node
        
    }
    
}
