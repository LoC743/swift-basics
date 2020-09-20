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
        
        let scene = GameScene(size: self.view.bounds.size)
        
        if let view = self.view as! SKView? {
            view.ignoresSiblingOrder = true // Произвольный порядок рендеринга объектов в узле
            
            view.showsFPS = true // Отображение FPS
            view.showsNodeCount = true // Показывать количество объектов на экране
            
            view.presentScene(scene)
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
