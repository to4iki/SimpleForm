//
//  SigninButtonViewController.swift
//  SimpleForm
//
//  Created by to4iki on 12/13/14.
//  Copyright (c) 2014 to4iki. All rights reserved.
//

import UIKit
import EmitterKit

protocol SigninButtonViewControllerDelegate: class {
    func getSigninContext() -> SigninContext
    func execSunccessEvent()
    func execErrorEvent(error: String)
}

class SigninButtonViewController: UIViewController {

    @IBOutlet weak var signinButton: UIButton!
    
    private var contextListener: Listener? = nil
    
    weak var delegate: SigninButtonViewControllerDelegate? {
        didSet {
            if let delegate = delegate {
                contextListener = delegate.getSigninContext().event.on { [weak self] (isAllEnterd: Bool) in
                    self?.signinButton.enabled = isAllEnterd; return
                }
                
            } else if let oldDelegate = oldValue {
                contextListener?.isListening = false
                contextListener = nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signinButton.addTarget(self, action: "onSignin", forControlEvents: .TouchUpInside)
    }
    
    func onSignin() {
        let context = delegate!.getSigninContext()
        
        // dummy
        // 本来はこのタイミングでDB問い合わせ
        if context.scope.email == "test@example.com" && context.scope.password == "test" {
            delegate!.execSunccessEvent()
        } else {
            delegate!.execErrorEvent("arg error")
        }
    }
}
