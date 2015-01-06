//
//  Dialog.swift
//  SimpleForm
//
//  Created by to4iki on 12/14/14.
//  Copyright (c) 2014 to4iki. All rights reserved.
//

import UIKit

class Dialog {
    
    /**
    show alert
    
    :param: callFrom
    :param: title
    :param: message
    :param: buttonTitle
    :param: handler
    */
    class func alert(callFrom: UIViewController, title: String?, message: String?, buttonTitle: String = "OK",  handler: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: buttonTitle, style: .Default,
            handler: { (sender) -> Void in
                handler?()
                return
        })
        
        alert.addAction(defaultAction)
        
        callFrom.presentViewController(alert, animated: true, completion:nil)
    }
}