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
    var passwordVerification: String = ""
}

class SigninContext {
    
    // change event
    let event = Event<Bool>()
    
    var scope: SigninViewScope = SigninViewScope() {
        didSet {
            event.emit(valid())
        }
    }
    
    private lazy var valid: (() -> Bool) = { () in
        self.required && self.minLength
    }
    
    private var required: Bool {
        return scope.email != "" || scope.password != "" ? true : false
    }
    
    private var minLength: Bool {
        return countElements(scope.password) >= 4
    }
    
    private var samePassword: Bool {
        return scope.password == scope.passwordVerification
    }
}

class ViewController: UIViewController, UITextFieldDelegate, SigninButtonViewControllerDelegate {
    
    @IBOutlet private weak var settingButton: UIButton!
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var passwordVerificationField: UITextField!
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
        self.passwordVerificationField.delegate = self
        self.signinButton?.delegate = self
        
        setupHandler()
    }
    
    private func setupHandler() {
        settingButton.addTarget(self, action: "openSetting", forControlEvents: .TouchUpInside)
    }
    
    func openSetting() {
        navigationController?.pushViewController(SettingStoryBoard().viewController, animated: true)
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
        case passwordVerificationField:
            context.scope.passwordVerification = passwordVerificationField.text
        default:
            break
        }
    }
    
    /**
    エンターを押した時
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            passwordVerificationField.becomeFirstResponder()
        default:
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
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        self.passwordVerificationField.resignFirstResponder()
    }
    
    // MARK: - SigninButtonViewControllerDelegate
    
    func getSigninContext() -> SigninContext {
        return context
    }
    
    func execSunccessEvent() {
        pushViewControllerWithDelay()
    }
    
    func execErrorEvent(error: String) {
        Dialog.alert(self, title: "error", message: error)
    }
    
    private lazy var pushViewControllerWithDelay: (() -> ()) = self.setupPushViewControllerWithDelay()
    
    private func setupPushViewControllerWithDelay() -> (() -> ()) {
        let delay = NSTimeInterval(2.0)
        let queue = dispatch_get_main_queue()
        let action: (() -> ()) = { [weak self] in
            self?.navigationController?.pushViewController(MainStoryBoard().confirmViewController, animated: true)
            return
        }
        
        Hud.showSuccessWithStatus(self.view, text: "Success", afterDelay: delay)
        return SimpleForm.debounce(delay, queue: queue, action: action)
    }
}
