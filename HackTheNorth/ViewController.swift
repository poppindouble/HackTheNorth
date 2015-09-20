//
//  ViewController.swift
//  HackTheNorth
//
//  Created by Shuangshuang Zhao on 2015-09-19.
//  Copyright © 2015 Shuangshuang Zhao. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
import Darwin

class ViewController: UIViewController{

    

    
    
    @IBOutlet weak var backGroundImage: UIImageView!
    var myImage: UIImageView?
    var upLeftCornerView: UIView?
    var upRightCornerView: UIView?
    var downLeftCornerView: UIView?
    var downRightCornerView: UIView?
    var CornerViewFrame: CGRect?
    let myImageFrame = CGRect(x: 0, y: 0, width: 150, height: 150)
    
    
    var imageArray = [UIImage]()
    var nameArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray.append(UIImage(named: "1")!)
        imageArray.append(UIImage(named: "2")!)
        imageArray.append(UIImage(named: "3")!)
        imageArray.append(UIImage(named: "4")!)
        imageArray.append(UIImage(named: "5")!)
        imageArray.append(UIImage(named: "6")!)
        imageArray.append(UIImage(named: "7")!)
        imageArray.append(UIImage(named: "8")!)
        
        
        nameArray.append("Obama")
        nameArray.append("Tom Cruise")
        nameArray.append("Mark Zuckerberg")
        nameArray.append("Putin")
        nameArray.append("Nicki Minaj")
        nameArray.append("Talor Swift")
        nameArray.append("Hillary Duff")
        nameArray.append("Tim Cook")
        
        

        
        
        myImage = UIImageView(frame: myImageFrame)
        myImage!.layer.cornerRadius = myImage!.layer.frame.width/2
        myImage!.clipsToBounds = true
        
        myImage!.userInteractionEnabled = true
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        myImage!.addGestureRecognizer(panGestureRecognizer)
        
        
        
        CornerViewFrame = CGRect(x: 0, y: 0, width: 250, height: 250)
        // make the up left corner view
        upLeftCornerView = UIView(frame: CornerViewFrame!)
        upLeftCornerView!.layer.cornerRadius = upLeftCornerView!.layer.frame.width/2
        upLeftCornerView!.center = self.view.frame.origin
        upLeftCornerView!.backgroundColor = UIColor(netHex: 0x445394)
        self.view.addSubview(upLeftCornerView!)
        
        //make the up right corner view
        upRightCornerView = UIView(frame: CornerViewFrame!)
        upRightCornerView!.layer.cornerRadius = upRightCornerView!.layer.frame.width/2
        upRightCornerView!.center = CGPoint(x: self.view.frame.maxX, y: 0)
        upRightCornerView!.backgroundColor = UIColor(netHex: 0x445394)
        self.view.addSubview(upRightCornerView!)
        
        //make the down left corner view
        downLeftCornerView = UIView(frame: CornerViewFrame!)
        downLeftCornerView!.layer.cornerRadius = downLeftCornerView!.layer.frame.width/2
        downLeftCornerView!.center = CGPoint(x: 0, y: self.view.frame.maxY)
        downLeftCornerView!.backgroundColor = UIColor(netHex: 0x445394)
        self.view.addSubview(downLeftCornerView!)
        
        //make the down right corner view
        downRightCornerView = UIView(frame: CornerViewFrame!)
        downRightCornerView!.layer.cornerRadius = downRightCornerView!.layer.frame.width/2
        downRightCornerView!.center = CGPoint(x: self.view.frame.maxX, y: self.view.frame.maxY)
        downRightCornerView!.backgroundColor = UIColor(netHex: 0x445394)
        self.view.addSubview(downRightCornerView!)
        
        // add the image view
        let diceRoll = Int(arc4random_uniform(8))
        myImage?.image = imageArray[diceRoll]
        myImage?.center = self.view.center
        self.view.addSubview(myImage!)
        
        // add the label
        let upLeftLabel = UILabel(frame: CGRectMake(0, 0, 80, 21))
        upLeftLabel.frame.origin = CGPointMake(15, 20)
        upLeftLabel.adjustsFontSizeToFitWidth = true
        upLeftLabel.textAlignment = NSTextAlignment.Left
        upLeftLabel.font = UIFont(name: "Helvetica Neue", size: 40)

        upLeftLabel.text = nameArray.last
        
        self.view.addSubview(upLeftLabel)
        
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Began {
        }
        
        if recognizer.state == UIGestureRecognizerState.Ended {
            
            if !CGRectIntersectsRect(upLeftCornerView!.frame, myImage!.frame) && !CGRectIntersectsRect(upRightCornerView!.frame, myImage!.frame) && !CGRectIntersectsRect(downLeftCornerView!.frame, myImage!.frame) && !CGRectIntersectsRect(downRightCornerView!.frame, myImage!.frame) {
                UIView.animateWithDuration(0.5, animations: {
                    myImage?.center = self.view.center
                })
            }
            
            
            if CGRectIntersectsRect(upLeftCornerView!.frame, myImage!.frame) {
                UIView.animateWithDuration(0.5, animations: {
                    self.myImage?.frame.size.width = 0
                    self.myImage?.frame.size.height = 0
                })
                
                UIView.animateWithDuration(0.5,
                    animations: {
                        if self.upLeftCornerView?.frame.size.width == (self.CornerViewFrame?.width)! + 200 {
                            self.upLeftCornerView?.frame.size.width = (self.CornerViewFrame?.width)!
                            self.upLeftCornerView?.frame.size.height = (self.CornerViewFrame?.height)!
                            self.upLeftCornerView?.layer.borderWidth = 0
                            self.upLeftCornerView?.layer.borderColor = UIColor.clearColor().CGColor
                            self.upLeftCornerView?.layer.backgroundColor = UIColor(netHex: 0x445394).CGColor
                            
                        }
                        self.upLeftCornerView?.center = self.view.frame.origin
                        self.upLeftCornerView?.layer.cornerRadius = (self.upLeftCornerView?.frame.width)!/2
                        
                    },
                    completion: { finished in
                        let diceRoll = Int(arc4random_uniform(8))
                        self.myImage?.frame = self.myImageFrame
                        self.myImage?.image = self.imageArray[diceRoll]
                        self.myImage?.center = self.view.center
                })
            }
            
            if CGRectIntersectsRect(upRightCornerView!.frame, myImage!.frame) {
                UIView.animateWithDuration(0.5, animations: {
                    self.myImage?.frame.size.width = 0
                    self.myImage?.frame.size.height = 0
                })
                
                UIView.animateWithDuration(0.5,
                    animations: {
                        if self.upRightCornerView?.frame.size.width == (self.CornerViewFrame?.width)! + 200 {
                            self.upRightCornerView?.frame.size.width = (self.CornerViewFrame?.width)!
                            self.upRightCornerView?.frame.size.height = (self.CornerViewFrame?.height)!
                            self.upRightCornerView?.layer.borderWidth = 0
                            self.upRightCornerView?.layer.borderColor = UIColor.clearColor().CGColor
                            self.upRightCornerView?.layer.backgroundColor = UIColor(netHex: 0x445394).CGColor
                            
                        }
                        self.upRightCornerView?.center = CGPoint(x: self.view.frame.maxX, y: 0)
                        self.upRightCornerView?.layer.cornerRadius = (self.upRightCornerView?.frame.width)!/2
                        
                    },
                    completion: { finished in
                        let diceRoll = Int(arc4random_uniform(8))
                        self.myImage?.frame = self.myImageFrame
                        self.myImage?.image = self.imageArray[diceRoll]
                        self.myImage?.center = self.view.center
                })
            }

            if CGRectIntersectsRect(downLeftCornerView!.frame, myImage!.frame) {
                UIView.animateWithDuration(0.5, animations: {
                    self.myImage?.frame.size.width = 0
                    self.myImage?.frame.size.height = 0
                })
                
                UIView.animateWithDuration(0.5,
                    animations: {
                        if self.downLeftCornerView?.frame.size.width == (self.CornerViewFrame?.width)! + 200 {
                            self.downLeftCornerView?.frame.size.width = (self.CornerViewFrame?.width)!
                            self.downLeftCornerView?.frame.size.height = (self.CornerViewFrame?.height)!
                            self.downLeftCornerView?.layer.borderWidth = 0
                            self.downLeftCornerView?.layer.borderColor = UIColor.clearColor().CGColor
                            self.downLeftCornerView?.layer.backgroundColor = UIColor(netHex: 0x445394).CGColor
                            
                        }
                        self.downLeftCornerView?.center = CGPoint(x: 0, y: self.view.frame.maxY)
                        self.downLeftCornerView?.layer.cornerRadius = (self.downLeftCornerView?.frame.width)!/2
                        
                    },
                    completion: { finished in
                        let diceRoll = Int(arc4random_uniform(8))
                        self.myImage?.frame = self.myImageFrame
                        self.myImage?.image = self.imageArray[diceRoll]
                        self.myImage?.center = self.view.center
                })
            }
            
            if CGRectIntersectsRect(downRightCornerView!.frame, myImage!.frame) {
                UIView.animateWithDuration(0.5, animations: {
                    self.myImage?.frame.size.width = 0
                    self.myImage?.frame.size.height = 0
                })
                
                UIView.animateWithDuration(0.5,
                    animations: {
                        if self.downRightCornerView?.frame.size.width == (self.CornerViewFrame?.width)! + 200 {
                            self.downRightCornerView?.frame.size.width = (self.CornerViewFrame?.width)!
                            self.downRightCornerView?.frame.size.height = (self.CornerViewFrame?.height)!
                            self.downRightCornerView?.layer.borderWidth = 0
                            self.downRightCornerView?.layer.borderColor = UIColor.clearColor().CGColor
                            self.downRightCornerView?.layer.backgroundColor = UIColor(netHex: 0x445394).CGColor
                            
                        }
                        self.downRightCornerView?.center = CGPoint(x: self.view.frame.maxX, y: self.view.frame.maxY)
                        self.downRightCornerView?.layer.cornerRadius = (self.downRightCornerView?.frame.width)!/2
                        
                    },
                    completion: { finished in
                        let diceRoll = Int(arc4random_uniform(8))
                        self.myImage?.frame = self.myImageFrame
                        self.myImage?.image = self.imageArray[diceRoll]
                        self.myImage?.center = self.view.center
                })
            }
            
            
        }
        if recognizer.state == UIGestureRecognizerState.Changed {
            let endLocation = recognizer.locationInView(self.view)
            UIView.animateWithDuration(0.01) {
                self.myImage!.center = endLocation
            }

            if CGRectIntersectsRect(upLeftCornerView!.frame, myImage!.frame) {
                UIView.animateWithDuration(0.5,
                    animations: {
                        self.upLeftCornerView?.frame.size.width = (self.CornerViewFrame?.width)! + 200
                        self.upLeftCornerView?.frame.size.height = (self.CornerViewFrame?.height)! + 200
                        self.upLeftCornerView?.layer.cornerRadius = (self.upLeftCornerView?.frame.width)!/2
                        self.upLeftCornerView?.center = self.view.frame.origin
                        self.upLeftCornerView?.layer.borderColor = UIColor.blackColor().CGColor
                        self.upLeftCornerView?.layer.backgroundColor = UIColor(netHex: 0x27315C).CGColor
                        self.upLeftCornerView?.layer.borderWidth = 10
                        
                    },
                    completion: { finished in

                    })

            } else if CGRectIntersectsRect(upRightCornerView!.frame, myImage!.frame) {
                UIView.animateWithDuration(0.5,
                    animations: {
                        self.upRightCornerView?.frame.size.width = (self.CornerViewFrame?.width)! + 200
                        self.upRightCornerView?.frame.size.height = (self.CornerViewFrame?.height)! + 200
                        self.upRightCornerView?.layer.cornerRadius = (self.upRightCornerView?.frame.width)!/2
                        self.upRightCornerView?.center = CGPoint(x: self.view.frame.maxX, y: 0)
                        self.upRightCornerView?.layer.borderColor = UIColor.blackColor().CGColor
                        self.upRightCornerView?.layer.backgroundColor = UIColor(netHex: 0x27315C).CGColor
                        self.upRightCornerView?.layer.borderWidth = 10
                    },
                    completion: { finished in
                })
            } else if CGRectIntersectsRect(downLeftCornerView!.frame, myImage!.frame) {
                
                UIView.animateWithDuration(0.5,
                    animations: {
                        self.downLeftCornerView?.frame.size.width = (self.CornerViewFrame?.width)! + 200
                        self.downLeftCornerView?.frame.size.height = (self.CornerViewFrame?.height)! + 200
                        self.downLeftCornerView?.layer.cornerRadius = (self.downLeftCornerView?.frame.width)!/2
                        self.downLeftCornerView?.center = CGPoint(x: 0, y: self.view.frame.maxY)
                        self.downLeftCornerView?.layer.borderColor = UIColor.blackColor().CGColor
                        self.downLeftCornerView?.layer.backgroundColor = UIColor(netHex: 0x27315C).CGColor
                        self.downLeftCornerView?.layer.borderWidth = 10
                    },
                    completion: { finished in
                })

                
                
                
            } else if CGRectIntersectsRect(downRightCornerView!.frame, myImage!.frame) {
                UIView.animateWithDuration(0.5,
                    animations: {
                        self.downRightCornerView?.frame.size.width = (self.CornerViewFrame?.width)! + 200
                        self.downRightCornerView?.frame.size.height = (self.CornerViewFrame?.height)! + 200
                        self.downRightCornerView?.layer.cornerRadius = (self.downRightCornerView?.frame.width)!/2
                        self.downRightCornerView?.center = CGPoint(x: self.view.frame.maxX, y: self.view.frame.maxY)
                        self.downRightCornerView?.layer.borderColor = UIColor.blackColor().CGColor
                        self.downRightCornerView?.layer.backgroundColor = UIColor(netHex: 0x27315C).CGColor
                        self.downRightCornerView?.layer.borderWidth = 10
                    },
                    completion: { finished in
                })

            }
            // consider the coverage of the corner view
            if !CGRectIntersectsRect(upLeftCornerView!.frame, myImage!.frame) {
                UIView.animateWithDuration(0.5,
                    animations: {
                        if self.upLeftCornerView?.frame.size.width == (self.CornerViewFrame?.width)! + 200 {
                            self.upLeftCornerView?.frame.size.width = (self.CornerViewFrame?.width)!
                            self.upLeftCornerView?.frame.size.height = (self.CornerViewFrame?.height)!
                            self.upLeftCornerView?.layer.borderWidth = 0
                            self.upLeftCornerView?.layer.borderColor = UIColor.clearColor().CGColor
                            self.upLeftCornerView?.layer.backgroundColor = UIColor(netHex: 0x445394).CGColor
                            
                        }
                        self.upLeftCornerView?.center = self.view.frame.origin
                        self.upLeftCornerView?.layer.cornerRadius = (self.upLeftCornerView?.frame.width)!/2
                        
                    },
                    completion: { finished in
                        
                })
            }
            if !CGRectIntersectsRect(upRightCornerView!.frame, myImage!.frame) {
                UIView.animateWithDuration(0.5,
                    animations: {
                        if self.upRightCornerView?.frame.size.width == (self.CornerViewFrame?.width)! + 200 {
                            self.upRightCornerView?.frame.size.width = (self.CornerViewFrame?.width)!
                            self.upRightCornerView?.frame.size.height = (self.CornerViewFrame?.height)!
                            self.upRightCornerView?.layer.borderWidth = 0
                            self.upRightCornerView?.layer.borderColor = UIColor.clearColor().CGColor
                            self.upRightCornerView?.layer.backgroundColor = UIColor(netHex: 0x445394).CGColor
                            
                        }
                        self.upRightCornerView?.center = CGPoint(x: self.view.frame.maxX, y: 0)
                        self.upRightCornerView?.layer.cornerRadius = (self.upLeftCornerView?.frame.width)!/2
                        
                    },
                    completion: { finished in
                })
            }
            
            if !CGRectIntersectsRect(downLeftCornerView!.frame, myImage!.frame) {
                UIView.animateWithDuration(0.5,
                    animations: {
                        if self.downLeftCornerView?.frame.size.width == (self.CornerViewFrame?.width)! + 200 {
                            self.downLeftCornerView?.frame.size.width = (self.CornerViewFrame?.width)!
                            self.downLeftCornerView?.frame.size.height = (self.CornerViewFrame?.height)!
                            self.downLeftCornerView?.layer.borderWidth = 0
                            self.downLeftCornerView?.layer.borderColor = UIColor.clearColor().CGColor
                            self.downLeftCornerView?.layer.backgroundColor = UIColor(netHex: 0x445394).CGColor
                            
                        }
                        self.downLeftCornerView?.center = CGPoint(x: 0, y: self.view.frame.maxY)
                        self.downLeftCornerView?.layer.cornerRadius = (self.downLeftCornerView?.frame.width)!/2
                        
                    },
                    completion: { finished in
                })
            }
            if !CGRectIntersectsRect(downRightCornerView!.frame, myImage!.frame) {
                UIView.animateWithDuration(0.5,
                    animations: {
                        if self.downRightCornerView?.frame.size.width == (self.CornerViewFrame?.width)! + 200 {
                            self.downRightCornerView?.frame.size.width = (self.CornerViewFrame?.width)!
                            self.downRightCornerView?.frame.size.height = (self.CornerViewFrame?.height)!
                            self.downRightCornerView?.layer.borderWidth = 0
                            self.downRightCornerView?.layer.borderColor = UIColor.clearColor().CGColor
                            self.downRightCornerView?.layer.backgroundColor = UIColor(netHex: 0x445394).CGColor
                            
                        }
                        self.downRightCornerView?.center = CGPoint(x: self.view.frame.maxX, y: self.view.frame.maxY)
                        self.downRightCornerView?.layer.cornerRadius = (self.downRightCornerView?.frame.width)!/2
                        
                    },
                    completion: { finished in
                })
            }
            
        }
        
    }
    
}


extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sortInPlace { (_,_) in arc4random() < arc4random() }
        }
    }
}



extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

