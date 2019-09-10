//
//  YTSubmitAnimateView.swift
//  YTSubmitButton_Swift
//
//  Created by soma on 2019/4/11.
//  Copyright © 2019 yitezh. All rights reserved.
//

import Foundation
import UIKit

let ANIMATETIME = 0.8

enum SubmitStatus {
    case SubmitStatusNormal,SubmitStatusDoing,SubmitStatusSuccess,SubmitStatusFailed;
    
}

class YTSubmitAnimateView:UIView,CAAnimationDelegate {
    // MARK: - public method
    public var submitStatus:SubmitStatus
    
    
    var rate = 0.0;
    lazy var roundLayer:CAShapeLayer = {
        let layer = CAShapeLayer();
        return layer;
    }()
    
    lazy  var checkLayer:CAShapeLayer = {
        let layer = CAShapeLayer();
        return layer;
    }()
    
    
    
    override init(frame: CGRect) {
        self.submitStatus = SubmitStatus.SubmitStatusNormal;
        super.init(frame: frame);
        
        self.addAnimationLayer();
    }
    
    func addAnimationLayer() -> () {
        let roundPath:UIBezierPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.height/2);
        self.roundLayer.path = roundPath.cgPath;
        self.roundLayer.strokeColor = UIColor.white.cgColor;
        self.roundLayer.fillColor = UIColor.clear.cgColor;
        self.roundLayer.lineWidth = 3;
        self.roundLayer.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height);
        self.layer.addSublayer(self.roundLayer);
        
        let insideRadius =  self.height/2-3;
        
        let checkPath:UIBezierPath = UIBezierPath();
        let secondPoint:CGPoint = self.calcCircleCoordinateWithCenter(center: CGPoint(x: self.width/2, y: self.height/2), angle: 240, radius: insideRadius);
        let thirdPoint:CGPoint = self.calcCircleCoordinateWithCenter(center: CGPoint(x: self.width/2, y: self.height/2), angle: 30, radius: insideRadius);
        checkPath.move(to: CGPoint(x: 0, y: self.height/2));
        checkPath.addLine(to: secondPoint);
        checkPath.addLine(to: thirdPoint);
        
        self.checkLayer.path = checkPath.cgPath;
        self.checkLayer.strokeColor = UIColor.white.cgColor;
        self.checkLayer.fillColor = UIColor.clear.cgColor;
        self.checkLayer.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height);
        self.checkLayer.lineWidth = 3;
        self.checkLayer.strokeEnd = 0;
        self.layer.addSublayer(self.checkLayer);
        
    }
    
    func calcCircleCoordinateWithCenter(center:CGPoint,angle:CGFloat,radius:CGFloat) -> CGPoint {
        
        let x2:CGFloat = radius*cos(angle*CGFloat.pi/180);
        let y2:CGFloat = radius*sin(angle*CGFloat.pi/180);
        return CGPoint(x:center.x+x2, y: center.y-y2);
    }
    
    func setSubmitStatus(submitStatus:SubmitStatus) -> () {
        self.submitStatus = submitStatus
        switch (submitStatus) {
        case .SubmitStatusDoing:
            self.showDoingAnimation();
            break;
        case .SubmitStatusSuccess:
             self.showSuccessAnimation();
            break;
        default:
            break;
        }
    }
    
    func showDoingAnimation()  {
        CATransaction.begin();
        CATransaction.setDisableActions(true);
        self.checkLayer.isHidden = true;
        
        let group = CAAnimationGroup();
        group.repeatCount = MAXFLOAT;
        
        let startAnimation = CABasicAnimation(keyPath:"strokeEnd");
        startAnimation.fromValue = 0;
        startAnimation.toValue = 0.9;
        startAnimation.beginTime = 0 ;
        startAnimation.duration = ANIMATETIME;
        startAnimation.fillMode = CAMediaTimingFillMode.forwards;
        startAnimation.isRemovedOnCompletion  = false;
        startAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.62, 0.0, 0.38, 1.0);
        
        let endAnimation:CABasicAnimation = CABasicAnimation(keyPath:"strokeStart");
        endAnimation.fromValue = 0;
        endAnimation.toValue = 0.9;
        endAnimation.beginTime = ANIMATETIME ;
        endAnimation.duration = ANIMATETIME;
        endAnimation.fillMode = CAMediaTimingFillMode.forwards;
        endAnimation.isRemovedOnCompletion  = false;
        endAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.62, 0.0, 0.38, 1.0);
        
        rate = Double.pi/2;
        
        let rotationAnimation:CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z");
        rotationAnimation.fromValue = rate;
        rotationAnimation.toValue = rate + 2 * Double.pi;
        rotationAnimation.duration =  2*ANIMATETIME;
        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards;
        rotationAnimation.isRemovedOnCompletion  = false;
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear);
        
        group.isRemovedOnCompletion = false;
        group.animations = [startAnimation,endAnimation,rotationAnimation];
        group.duration = 2*ANIMATETIME;
        self.roundLayer.removeAllAnimations();
        self.roundLayer.add(group, forKey: "round_group_ani");
        
        CATransaction.commit();
    }
    
    func showSuccessAnimation() -> Void {
        CATransaction.begin();
        CATransaction.setDisableActions(true);
        self.checkLayer.isHidden = false;
        self.roundLayer.removeAllAnimations();
        self.showRoundAnimation();
        self.showCheckAnimation();
        CATransaction.commit();
    }
    
    func showCheckAnimation() -> Void {
        let checkAnimation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath:"strokeEnd");
        checkAnimation.values = [0,0.4,0.8,1.03,0.97,1];
        checkAnimation.beginTime = CACurrentMediaTime()+0.5 ;
        checkAnimation.duration = 0.4;
        checkAnimation.fillMode = CAMediaTimingFillMode.forwards;
        checkAnimation.isRemovedOnCompletion  = false;
        checkAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
                                          CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
                                          CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
                                          CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
                                          CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
                                          CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)];
        self.checkLayer.add(checkAnimation, forKey: "check_check_ani");
    }
    
    func showRoundAnimation() -> Void {
        let startAnimation = CABasicAnimation(keyPath:"strokeEnd");
        startAnimation.fromValue = 0;
        startAnimation.toValue = 1;
        startAnimation.beginTime = 0 ;
        startAnimation.duration = ANIMATETIME;
        startAnimation.fillMode = CAMediaTimingFillMode.forwards;
        startAnimation.isRemovedOnCompletion  = false;
        self.roundLayer .add(startAnimation, forKey: "check_round_ani");
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
