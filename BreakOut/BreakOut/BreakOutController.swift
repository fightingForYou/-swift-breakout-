//
//  BreakOutController.swift
//  BreakOut
//
//  Created by 卡神 on 15/7/23.
//  Copyright © 2015年 lok. All rights reserved.
//

import UIKit

class BreakOutController: UIViewController, UICollisionBehaviorDelegate {

    
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var brick: UIView!
    @IBOutlet weak var ball: UIView!
    @IBAction func moveBrick(sender: UIPanGestureRecognizer) {
        switch sender.state  {
        case .Changed:
            let move = sender.translationInView(gameView).x
            brick.center = CGPoint(x: brick.center.x + move, y: brick.center.y)
            let origion = brick.frame.origin
            let point = CGPoint(x: origion.x + brick.frame.size.width, y: origion.y)
            myDynamic.collisionBehavior.removeBoundaryWithIdentifier("move")
            myDynamic.collisionBehavior.addBoundaryWithIdentifier("move", fromPoint: origion, toPoint: point)
            sender.setTranslation(CGPointZero, inView: gameView)
        default:
            break
        }
    }
   
    
    let numberOfRow = 5
    let numberOfSection = 5
    
    var lengthOfScetion: CGFloat {
        return self.view.bounds.height / 4
    }
    var width: CGFloat {
        return self.view.bounds.width / CGFloat(self.numberOfRow)
    }
    
    var height: CGFloat {
        return self.lengthOfScetion / CGFloat(numberOfSection)
    }
    
    lazy var animator: UIDynamicAnimator = {
        let lazyAnimator = UIDynamicAnimator(referenceView: self.gameView)
        return lazyAnimator
    }()
    
    var myDynamic = MyDynamicBehavior()
    
    
    
    
    func createView() {
        for i in 0...4 {
            for j in 0...4 {
                let frame = CGRectMake(CGFloat(i) * width, CGFloat(j) * height, width, height)
                let view = UIView(frame: frame)
                view.backgroundColor = UIColor.randomColor()
                myDynamic.addCollisionItem(view)
            }
        }
    }
    
//    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
//        behavior.removeItem(item2)
//        myDynamic.addGravity(item2)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myDynamic.collisionBehavior.collisionDelegate = self
        self.animator.addBehavior(myDynamic)
        self.createView()
        myDynamic.collisionBehavior.addItem(ball)
        myDynamic.pushBall([self.ball])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

private extension UIColor {
    class func randomColor() -> UIColor{
        let random = arc4random() % 5
        switch random {
        case 0: return UIColor.redColor()
        case 1: return UIColor.greenColor()
        case 2: return UIColor.yellowColor()
        case 3: return UIColor.blueColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.whiteColor()
        }
    }
}
