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
    class func alert(callFrom: UIViewController, title: String?, message: String?, buttonTitle: String = "ok",  handler: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: buttonTitle, style: .Default,
            handler: { (sender) -> Void in
                handler?()
                return
        })
        
        alert.addAction(defaultAction)
        
        callFrom.presentViewController(alert, animated: true, completion:nil)
    }
    
    /**
    show prompt
    
    :param: callFrom
    :param: title
    :param: message
    :param: configurationHandlers
    :param: cancelOrLeftButtonTitl
    :param: okOrRightButtonTitle
    :param: cancelOrLeftHandler
    :param: okOrRightHandler
    */
    class func prompt (
        callFrom: UIViewController,
        title: String?,
        message: String?,
        configurationHandlers: [((UITextField!) -> ())],
        cancelOrLeftButtonTitle: String = "cancel",
        okOrRightButtonTitle: String = "ok",
        cancelOrLeftHandler: (()->())? = nil,
        okOrRightHandler: (()->())? = nil
        ) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            for handler in configurationHandlers {
                alert.addTextFieldWithConfigurationHandler(handler)
            }
            
            let leftAction = UIAlertAction(title: cancelOrLeftButtonTitle, style: .Cancel) { _ in
                cancelOrLeftHandler?(); return
            }
            alert.addAction(leftAction)
            
            let rightAction = UIAlertAction(title: okOrRightButtonTitle, style: .Default) { _ in
                okOrRightHandler?(); return
            }
            alert.addAction(rightAction)
            
            callFrom.presentViewController(alert, animated: true, completion: nil)
    }
}