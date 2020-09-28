//
//  GameScene.swift
//  BasicSnakeGame
//
//  Created by Алексей Морозов on 20.09.2020.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var snake: Snake?
    
    let gameOverDuration: TimeInterval = 1.5
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.SnakeHead
        
        view.showsPhysics = true
        
        addCounterClockwiseButton()
        addClockwiseButton()
        
        createApple()
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
    }
    
    func addCounterClockwiseButton() {
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwiseButton.position = CGPoint(x: view!.scene!.frame.minX + 30, y: view!.scene!.frame.minY + 30)
        counterClockwiseButton.fillColor = .gray
        counterClockwiseButton.strokeColor = .gray
        counterClockwiseButton.lineWidth = 5
        counterClockwiseButton.name = "counterClockwiseButton"
        
        self.addChild(counterClockwiseButton)
    }
    
    func addClockwiseButton() {
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwiseButton.position = CGPoint(x: view!.scene!.frame.maxX - 80, y: view!.scene!.frame.minY + 30)
        clockwiseButton.fillColor = .gray
        clockwiseButton.strokeColor = .gray
        clockwiseButton.lineWidth = 5
        clockwiseButton.name = "clockwiseButton"
        
        self.addChild(clockwiseButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                  touchedNode.name == "counterClockwiseButton" ||
                  touchedNode.name == "clockwiseButton"
            else { return }
            
            touchedNode.fillColor = .lightGray
            
            if touchedNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            } else if touchedNode.name == "clockwiseButton" {
                snake!.moveClockwise()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.atPoint(touchLocation) as? SKShapeNode,
                  touchedNode.name == "counterClockwiseButton" ||
                    touchedNode.name == "clockwiseButton"
            else { return }
            
            touchedNode.fillColor = .gray
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
    }
    
    func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 5)) + 1)
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 5)) + 1)
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        
        self.addChild(apple)
    }
    
    func gameOver() {
        func restart() {
            snake = Snake(atPoint: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midY))
            addChild(snake!)
            addCounterClockwiseButton()
            addClockwiseButton()
            createApple()
        }
        
        let score = snake?.getScore() ?? 0
        
        self.removeAllChildren()
        
        let gameOver = SKLabelNode(fontNamed: "Helvetica Light")
        gameOver.text = "Game over!\nYour score: \(score)"
        gameOver.numberOfLines = 2
        gameOver.fontSize = 30
        gameOver.fontColor = .white
        gameOver.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let wait = SKAction.wait(forDuration: gameOverDuration)
        let remove = SKAction.removeFromParent()
        let start = SKAction.run { restart() }
        let sequence = SKAction.sequence([wait, remove, start])
        
        addChild(gameOver)

        gameOver.run(sequence)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodyes ^ CollisionCategories.SnakeHead
        
        switch collisionObject {
        case CollisionCategories.Apple:
            let apple = contact.bodyA.node
                is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
        case CollisionCategories.EdgeBody:
            gameOver()
        default:
            break
        }
    }
}

struct CollisionCategories {
    static let Snake: UInt32 = 0x1 << 0
    static let SnakeHead: UInt32 = 0x1 << 1
    static let Apple: UInt32 = 0x1 << 2
    static let EdgeBody: UInt32 = 0x1 << 3
}
