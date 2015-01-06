//
//  Hud.swift
//  SimpleForm
//
//  Created by to4iki on 12/15/14.
//  Copyright (c) 2014 to4iki. All rights reserved.
//

import Foundation

/**
*  Head Up Display
*/
class Hud {
    
    lazy private var successImageView: UIImageView = {
        let icon = FAKIonIcons.iosCheckmarkIconWithSize(28)
        icon.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor())
        let image = icon.imageWithSize(CGSizeMake(28, 28))
        
        return UIImageView(image: image)
        }()
    
    /**
    show loading with label
    
    :param: view
    :param: text
    :param: detailsText
    */
    class func showWithStatus(view: UIView, text: String, detailsText: String? = nil) {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        hud.mode = MBProgressHUDModeIndeterminate
        hud.labelText = text
        hud.detailsLabelText = detailsText ?? ""
    }
    
    /**
    show success popup with label
    
    :param: view
    :param: text
    :param: detailsText
    :param: afterDelay
    */
    class func showSuccessWithStatus(view: UIView, text: String, detailsText: String? = nil, afterDelay: NSTimeInterval? = nil) {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)

        hud.mode = MBProgressHUDModeCustomView
        hud.labelText = text
        hud.detailsLabelText = detailsText ?? ""
        hud.customView = Hud().successImageView
        
        hud.hide(true, afterDelay: afterDelay ?? 3.0)
    }
    
    
    /**
    hide all hud
    
    :param: view
    :param: animated
    */
    class func hideAll(view: UIView, animated: Bool) {
        MBProgressHUD.hideAllHUDsForView(view, animated: animated)
    }
}