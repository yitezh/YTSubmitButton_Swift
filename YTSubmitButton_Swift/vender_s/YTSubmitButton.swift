//
//  YTSubmitButton.swift
//  YTSubmitButton_Swift
//
//  Created by soma on 2019/4/11.
//  Copyright © 2019 yitezh. All rights reserved.
//

import Foundation
import UIKit

let topInset = 10
@objc public protocol YTSubmitButtonDelegate: NSObjectProtocol{
    @objc optional
    func didClickSubmitButton() -> Void ;
}

class YTSubmitButton: UIView  {
    public weak var delegate: YTSubmitButtonDelegate?
    // MARK: - setter getter
    private var _normalStatusText:String?;
    public var normalStatusText:String {
        get {
            return _normalStatusText ?? "提交";
        }
        set {
            _normalStatusText = newValue;
            self.resetView();
        }
    }
    
    private var _doingStatusText:String?;
    public var doingStatusText:String {
        get {
            return _doingStatusText ?? "提交中";
        }
        set {
            _doingStatusText = newValue;
            self.resetView();
        }
    }
    
    private var _successStatusText:String?;
    public var successStatusText:String{
        get {
            return _successStatusText ?? "提交成功";
        }
        set {
            _successStatusText = newValue;
            self.resetView();
        }
    }
    
    private var _failedStatusText:String?;
    public var failedStatusText:String{
        get {
            return _failedStatusText ?? "重试";
        }
        set {
            _failedStatusText = newValue;
            self.resetView();
        }
    }
    private var _submitStatus:SubmitStatus?
    public var submitStatus:SubmitStatus {
        get {
            return  _submitStatus ?? .SubmitStatusNormal;
        }
        set {
            _submitStatus = newValue;
            switch (newValue) {
            case .SubmitStatusNormal:
                self.showNormalView();
                break;
            case .SubmitStatusDoing:
                self.showDoinglView();
                break;
            case .SubmitStatusSuccess:
                self.showSuccessView();
                break;
            case .SubmitStatusFailed:
                self.showFailedView();
                self.showShakeAnimation();
                break;
            }
            self.animationView.setSubmitStatus(submitStatus: newValue);
            self.setNeedsLayout();
        }
        
    }
    public var animationRadius:CGFloat;
    
    
    lazy var titleLabel:UILabel = {
        var  label = UILabel();
        label.numberOfLines = 1;
        label.textColor = UIColor.white;
        label.textAlignment = NSTextAlignment.left;
        return label;
    }()
    
    lazy var animationView :YTSubmitAnimateView={
       var animationView:YTSubmitAnimateView = YTSubmitAnimateView(frame:CGRect(x:CGFloat(10), y:CGFloat(topInset), width: self.animationRadius*2, height:  self.animationRadius*2))
       return animationView;
    }()
    
    init(frame: CGRect,animationRadius: CGFloat) {
        self.animationRadius = animationRadius;
        
        super.init(frame: frame);
        self.submitStatus = .SubmitStatusNormal;
        self.setUpContentView();
        self.addClickGesture();
    }
    
    override func layoutSubviews() {
        self.titleLabel.center = CGPoint(x:self.width/2,y: self.height/2);
        self.animationView.x = self.titleLabel.frame.minX - self.animationView.width-10;
        self.animationView.center = CGPoint(x:self.animationView.center.x,y: self.titleLabel.center.y);
    }
    

    
    func addClickGesture ()->Void {
      let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction(action:)))

      self.addGestureRecognizer(tap);
    }
    
    @objc  func  tapAction(action:Any?)->Void {
      if(self.submitStatus == .SubmitStatusNormal||self.submitStatus == .SubmitStatusFailed)
      {

            self.delegate?.didClickSubmitButton?();
      }
    }
    
    func showShakeAnimation() -> Void {

        let shake = CABasicAnimation(keyPath:"transform.translation.x");
        shake.fromValue = -1;
        shake.toValue = 1;
        shake.duration = 0.05;
        shake.autoreverses = true;
        shake.repeatCount = 2;//次数
        self.layer.add(shake, forKey: "shakeAnimation");

    }
    
    func setUpContentView() -> Void {
        self.backgroundColor = UIColor.init(red: 16/255, green: 142/255, blue: 233/255, alpha: 1)
        self.addSubview(self.titleLabel);
        self.addSubview(self.animationView);
    }
    
    
    func showNormalView ()->Void{
    self.titleLabel.text = self.normalStatusText;
    self.titleLabel.sizeToFit();
    self.animationView.isHidden = true;
    }
    
    func showDoinglView ()->Void{
    self.titleLabel.text = self.doingStatusText;
   self.titleLabel.sizeToFit();
    self.animationView.isHidden = false;
    }
    
    func showSuccessView ()->Void{
    self.titleLabel.text = self.successStatusText;
    self.titleLabel.sizeToFit();
    self.animationView.isHidden = false;
    }
    
    func showFailedView ()->Void {
    self.titleLabel.text = self.failedStatusText;
    self.titleLabel.sizeToFit();
    self.animationView.isHidden = true;
    }
    
    func resetView()->Void{

     self.submitStatus = .SubmitStatusNormal;
     self.setNeedsLayout();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initSubView() -> Void {
        
    }
}





