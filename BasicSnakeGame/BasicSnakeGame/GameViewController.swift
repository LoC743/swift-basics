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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let skView = self.view as! SKView? {
            skView.ignoresSiblingOrder = true // Произвольный порядок рендеринга объектов в узле
            skView.allowsTransparency = true
            skView.showsFPS = true // Отображение FPS
            skView.showsNodeCount = true // Показывать количество объектов на экране
            
            let scene = GameScene(size: view.bounds.size)
            scene.backgroundColor = UIColor(red: 42/255, green: 43/255, blue: 47/255, alpha: 1.0)
                
            skView.presentScene(scene)
        }
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
