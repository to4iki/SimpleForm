//
//  TextFieldContainer.swift
//  SimpleForm
//
//  Created by to4iki on 2014/10/27.
//  Copyright (c) 2014年 to4iki. All rights reserved.
//

import UIKit

@IBDesignable //CustomViewをStoryboard上にレンダリング、見た目を確認出来るように
class TextFieldContainer: UITextField {
    
    private var width: CGFloat {
        get {
            return CGRectGetWidth(frame) //横幅取得
        }
    }
    
    private var height: CGFloat {
        get {
            return CGRectGetHeight(frame) //縦幅取得
        }
    }
    
    private let borderBottom: CALayer = CALayer()

    // CustomViewのプロパティをStoryboardから変更できるように
    @IBInspectable var borderBottomWidth: CGFloat = 0 {
        didSet {
            self.initBoarderBottom()
        }
    }
    
    // CustomViewのプロパティをStoryboardから変更できるように
    @IBInspectable var borderColor: UIColor = UIColor.lightGrayColor() {
        didSet {
            self.initBoarderBottom()
        }
    }
    
    /**
    タッチ開始時
    */
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        subviews.first?.becomeFirstResponder() //フォーカスを当てる
    }
    
    private func initBoarderBottom() {
        self.borderBottom.removeFromSuperlayer()
        self.borderBottom.frame = CGRectMake(0, self.height - self.borderBottomWidth, self.width, self.borderBottomWidth)
        self.borderBottom.backgroundColor = self.borderColor.CGColor
        layer.addSublayer(self.borderBottom)
    }
}