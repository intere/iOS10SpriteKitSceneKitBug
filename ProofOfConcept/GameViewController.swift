//
//  GameViewController.swift
//  ProofOfConcept
//
//  Created by Internicola, Eric on 9/4/16.
//  Copyright © 2016 iColasoft. All rights reserved.
//

import UIKit
import QuartzCore
import SpriteKit
import SceneKit

class GameViewController: UIViewController {

    var skView: SKView? {
        return self.view as? SKView
    }

    var scnNode: SK3DNode?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let skView = skView else {
            assert(false, "We don't have an SKView")
            return
        }
        
        // create a new SCNScene
        let scene = SCNScene(named: "art.scnassets/scene.scn")!

        // retrieve the ship node
        let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
        
        // animate the 3d object
        ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))

        let scnNode = SK3DNode(viewportSize: skView.bounds.size)
        scnNode.scnScene = scene
        
        // configure the view
        skView.backgroundColor = UIColor.green

        // Create the SKScene
        let skScene = SKScene(size: view.frame.size)
        skScene.scaleMode = .resizeFill
        skScene.addChild(scnNode)
        scnNode.position = CGPoint(x: skScene.frame.midX, y: skScene.frame.midY)

        skView.presentScene(skScene)
        self.scnNode = scnNode
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
