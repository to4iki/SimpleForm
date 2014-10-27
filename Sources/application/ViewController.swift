//
//  ViewController.swift
//  SimpleForm
//
//  Created by to4iki on 2014/10/26.
//  Copyright (c) 2014年 to4iki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailField.delegate = self
        self.passwordField.delegate = self
        self.signinButton.addTarget(self, action: "onSignin", forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onSignin() {
        println("signin")
    }
    
    // MARK: - UITextFieldDelegate
    
    /**
    エンターを押した時
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.emailField {
            self.passwordField?.becomeFirstResponder() //フォーカスを当てる
        } else {
            onSignin()
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
}

