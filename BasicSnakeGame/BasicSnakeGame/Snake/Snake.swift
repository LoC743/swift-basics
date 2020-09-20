//
//  Snake.swift
//  BasicSnakeGame
//
//  Created by Алексей Морозов on 20.09.2020.
//

import UIKit
import SpriteKit

class Snake: SKShapeNode {
    var body = [SnakeBodyPart]()
    
    let moveSpeed = 125.0
    var angle: CGFloat = 0.0
    
    convenience init(atPoint point: CGPoint) {
        self.init()
        
        let head = SnakeHead(atPoint: point)
        
        body.append(head)
        
        addChild(head)
    }
    
    func addBodyPart() {
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: body[0].position.x, y: body[0].position.y))
        
        body.append(newBodyPart)
        
        addChild(newBodyPart)
    }
    
    func moveHead(_ head: SnakeBodyPart) {
        let dx = CGFloat(moveSpeed) * sin(angle)
        let dy = CGFloat(moveSpeed) * cos(angle)
        
        let nextPostition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        let moveAction = SKAction.move(to: nextPostition, duration: 1.0)
        
        head.run(moveAction)
    }
    
    func moveBodyPart(_ previousPart: SnakeBodyPart, currentPart: SnakeBodyPart) {
        let moveAction = SKAction.move(to: CGPoint(x: previousPart.position.x, y: previousPart.position.y), duration: 0.1)
        currentPart.run(moveAction)
    }
    
    func move() {
        guard !body.isEmpty else { return }
        
        let head = body[0]
        moveHead(head)
        
        for index in (0..<body.count) where index > 0 {
            let previousBodyPart = body[index - 1]
            let currentBodyPart = body[index]
            moveBodyPart(previousBodyPart, currentPart: currentBodyPart)
        }
    }
    
    func moveClockwise() {
        angle += CGFloat(Double.pi/2)
    }
    
    func moveCounterClockwise() {
        angle -= CGFloat(Double.pi/2)
    }
}
