//
//  SnakeHead.swift
//  BasicSnakeGame
//
//  Created by Алексей Морозов on 20.09.2020.
//

import UIKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
