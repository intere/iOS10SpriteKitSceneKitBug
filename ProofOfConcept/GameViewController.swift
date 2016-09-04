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

/**
 * This class demonstrates a Bug in iOS10 when embedding a SceneKit Scene within a SpriteKitScene via a SK3DScene object
 */
class GameViewController: UIViewController {

    var skView: SKView? {
        return self.view as? SKView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.  Ensure we can get a reference to the SKView
        guard let skView = skView else {
            assert(false, "We don't have an SKView")
            return
        }
        
        // 2.  Load the SCNScene (includes ship, camera and light)
        let scene = SCNScene(named: "art.scnassets/scene.scn")!

        // 3.  Get a reference to the ship
        let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
        
        // 4.  Begin animating the Ship
        ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))

        // 5.  Create an SK3DNode to load the SCNScene into:
        let scnNode = SK3DNode(viewportSize: skView.bounds.size)
        scnNode.scnScene = scene

        // 6.  Create an SKScene
        let skScene = SKScene(size: view.frame.size)

        // 7.  Position and add the SK3DNode to the SKScene:
        scnNode.position = CGPoint(x: skScene.frame.midX, y: skScene.frame.midY)
        skScene.addChild(scnNode)

        // 8.  Present the SKScene
        skView.presentScene(skScene)

        // BUG: Note that the ship does not animate, unless you tap the view, then you get an updated redraw of the scene
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
