//
//  BorderedButton.swift
//  SimpleForm
//
//  Created by to4iki on 2014/10/28.
//  Copyright (c) 2014年 to4iki. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedButton: UIButton {

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
