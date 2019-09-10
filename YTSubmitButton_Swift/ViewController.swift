//
//  ViewController.swift
//  YTSubmitButton_Swift
//
//  Created by soma on 2019/4/11.
//  Copyright © 2019 yitezh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,YTSubmitButtonDelegate {

    @IBOutlet weak var passTextField: UITextField!
    private var submitView:YTSubmitButton?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let  submitView:YTSubmitButton = YTSubmitButton(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 50), animationRadius: 15);
        submitView.normalStatusText = "支付";
        submitView.doingStatusText = "支付中";
        submitView.delegate = self;
        self.submitView = submitView;
        
        self.view.addSubview(submitView);
        
        // Do any additional setup after loading the view.
    }
    
    func didClickSubmitButton() {
        
        self.submitView?.submitStatus = .SubmitStatusDoing;
        let queue = DispatchQueue.main;
        queue.asyncAfter(deadline: DispatchTime.now()+3 ) {
            if self.passTextField.text == "12345"
            {
                 self.submitView?.submitStatus = .SubmitStatusSuccess;
            }
            else {
                self.submitView?.submitStatus = .SubmitStatusFailed;
            }
        };
        
    }


    @IBAction func resetButtonClicked(_ sender: Any) {
          self.submitView?.submitStatus = .SubmitStatusNormal;
        
    }
}

