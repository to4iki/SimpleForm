//
//  DeleteButtonViewController.swift
//  SimpleForm
//
//  Created by to4iki on 1/22/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

import UIKit

protocol DeleteButtonDelegate: class {
    func onDeleteSuccess()
    func onDeleteError(error: String)
}

class DeleteButtonViewController: UIViewController {

    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: DeleteButtonDelegate?    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        setupHandlers()
    }
    
    override func viewDidDisappear(animated: Bool) {
        clearHandlers()
    }
    
    private func setupHandlers() {
        deleteButton.bk_addEventHandler({ [weak self] sender in
            self?.openPrompt(sender); return
            }, forControlEvents: .TouchUpInside)
    }
    
    private func clearHandlers() {
        deleteButton.bk_removeEventHandlersForControlEvents(.TouchUpInside)
    }
    
    
    func openPrompt(sender: AnyObject) {
        
        weak var passwordField: UITextField!
        let passwordFieldWithConfigurationHandler: ((UITextField!) -> ()) = { (textField: UITextField!) in
            passwordField = textField
            textField.placeholder = "password"
            textField.secureTextEntry = true
        }
        
        Dialog.prompt(
            self,
            title: "delete",
            message: nil,
            configurationHandlers: [passwordFieldWithConfigurationHandler],
            okOrRightHandler: {
                self.execDeactivation(passwordField.text)
            }
        )
    }
    
    func execDeactivation(password: String) {
        // dummy
        if password == "password" {
            delegate!.onDeleteSuccess()
        } else {
            delegate!.onDeleteError("invalid password.")
        }
    }
}
