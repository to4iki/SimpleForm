//
//  ViewController.swift
//  SimpleForm
//
//  Created by to4iki on 2014/10/26.
//  Copyright (c) 2014年 to4iki. All rights reserved.
//

import UIKit
import EmitterKit

final class MainStoryBoard {
    
    let storyboard: UIStoryboard
    let mainViewController: ViewController
    let confirmViewController: ConfirmViewController
    
    init() {
        self.storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: ConfirmViewController.self))
        self.mainViewController =
            self.storyboard.instantiateViewControllerWithIdentifier("ViewController") as ViewController
        self.confirmViewController =
            self.storyboard.instantiateViewControllerWithIdentifier("ConfirmViewController") as ConfirmViewController
    }
}

struct SigninViewScope {
    var email: String = ""
    var password: String = ""
}

class SigninContext {
    
    // change event
    let event = Event<Bool>()
    
    var scope: SigninViewScope = SigninViewScope() {
        didSet {
            event.emit(!anyNotEnterd())
        }
    }
    
    private func anyNotEnterd() -> Bool {
        if scope.email == "" || scope.password == "" {
            return true
        } else {
            return false
        }
    }
}

class ViewController: UIViewController, UITextFieldDelegate, SigninButtonViewControllerDelegate {
    
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    private weak var signinButton: SigninButtonViewController?
    
    private var context = SigninContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        // サブビューから関係コントローラーを抽出
        for subview in self.childViewControllers{
            switch subview {
            case let subview as SigninButtonViewController:
                self.signinButton = subview
            default:
                break
            }
        }
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.signinButton?.delegate = self
    }
    
    // MARK: - UITextFieldDelegate
    
    /**
    scopeにset
    */
    func textFieldDidEndEditing(textField: UITextField) {
        switch textField {
        case emailField:
            context.scope.email = emailField.text
        case passwordField:
            context.scope.password = passwordField.text
        default: 
            break
        }
    }
    
    /**
    エンターを押した時
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.emailField {
            passwordField?.becomeFirstResponder()
        } else {
            resignFirstResponderAtControls()
        }
        
        return true
    }
    
    /**
    タッチ開始時
    */
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        resignFirstResponderAtControls()
    }
    
    /**
    フォーカスを外す
    */
    private func resignFirstResponderAtControls() {
        self.emailField?.resignFirstResponder()
        self.passwordField?.resignFirstResponder()
    }
    
    // MARK: - SigninButtonViewControllerDelegate
    
    func getSigninContext() -> SigninContext {
        return context
    }
    
    func execSunccessEvent() {
        let delay = 3.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        Hud.showSuccessWithStatus(self.view, text: "Success", afterDelay: delay)
        dispatch_after(time, dispatch_get_main_queue(), {
            self.navigationController?.pushViewController(MainStoryBoard().confirmViewController, animated: true)
            return
        })
    }
    
    func execErrorEvent(error: String) {
        Dialog.alert(self, title: "error", message: error)
    }
}
