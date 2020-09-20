//
//  GameViewController.swift
//  BasicSnakeGame
//
//  Created by Алексей Морозов on 20.09.2020.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    lazy var skView: SKView = {
        let view = SKView(frame: self.view.frame)
        view.backgroundColor = .blue
        view.showsFPS = true
        view.showsNodeCount = true
        view.ignoresSiblingOrder = true

        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(skView)
        
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFit
    
        skView.presentScene(scene)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
