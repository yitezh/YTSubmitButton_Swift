//
//  UIView+ReFrame.swift
//  YTSubmitButton_Swift
//
//  Created by soma on 2019/4/11.
//  Copyright © 2019 yitezh. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    
    var height:(CGFloat) {
        get {
            return self.frame.size.height;
        }
        set {
            var rect:CGRect = self.frame;
            rect.size.height = newValue;
            self.frame = rect;
        }
    }
    
    var width:(CGFloat) {
        get {
            return self.frame.size.width;
        }
        set {
            var rect:CGRect = self.frame;
            rect.size.width = newValue;
            self.frame = rect;
        }
    }
    
    var x:(CGFloat) {
        get {
            return self.frame.origin.x;
        }
        set {
            var rect:CGRect = self.frame;
            rect.origin.x = newValue;
            self.frame = rect;
        }
    }


    var y:(CGFloat) {
        get {
            return self.frame.origin.y;
        }
        set {
            var rect:CGRect = self.frame;
            rect.origin.y = newValue;
            self.frame = rect;
        }
    }
    
    
    
    
    
}
