//
//  MyDynamicBehavior.swift
//  BreakOut
//
//  Created by 卡神 on 15/7/23.
//  Copyright © 2015年 lok. All rights reserved.
//

import UIKit

class MyDynamicBehavior: UIDynamicBehavior {
    
    lazy var collisionBehavior: UICollisionBehavior = {
        let lazyCollision = UICollisionBehavior()
        lazyCollision.addBoundaryWithIdentifier("one", fromPoint: CGPoint(x: 0, y: 667), toPoint: CGPoint(x: 0, y: 0))
        lazyCollision.addBoundaryWithIdentifier("two", fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 375, y: 0))
        lazyCollision.addBoundaryWithIdentifier("three", fromPoint: CGPoint(x: 375, y: 0), toPoint: CGPoint(x: 375, y: 667))
        return lazyCollision
        }()
    
    lazy var dynamicItem: UIDynamicItemBehavior = {
        let lazyItemBehavior = UIDynamicItemBehavior()
        lazyItemBehavior.elasticity = 1.0
        
        lazyItemBehavior.allowsRotation = true;
        return lazyItemBehavior
    }()
    
    var gravity = UIGravityBehavior()
    
    override init() {
        super.init()
        self.addChildBehavior(collisionBehavior)
        self.addChildBehavior(dynamicItem)
    }
    
    func pushBall(ball: [UIView]) {
        let push = UIPushBehavior(items: ball, mode: UIPushBehaviorMode.Instantaneous)
        push.magnitude = 3
        push.pushDirection = CGVectorMake(2, -2)
        push.action = {
            [unowned push] in
            push.dynamicAnimator?.removeBehavior(push)
            
        }
        self.dynamicAnimator?.addBehavior(push)
        
    }
    
    func addGravity(item: UIDynamicItem) {
        gravity.addItem(item)
    }
    
    func removeGravity(item: UIView) {
        gravity.removeItem(item)
        item.removeFromSuperview()
    }
    
    func addCollisionItem(item: UIView) {
        self.dynamicAnimator?.referenceView?.addSubview(item)
        collisionBehavior.addItem(item)
    }
    
    func removeCollisionItem(item: UIView) {
        collisionBehavior.removeItem(item)
    }
}
