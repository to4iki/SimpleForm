//
//  PasswordFormTableViewController.swift
//  SimpleForm
//
//  Created by to4iki on 1/12/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

import UIKit

final class PasswordFormStoryBoard {
    
    let storyboard: UIStoryboard
    let viewController: PasswordFormTableViewController
    
    init() {
        self.storyboard = UIStoryboard(name: "PasswordForm", bundle: NSBundle(forClass: PasswordFormTableViewController.self))
        self.viewController =
            self.storyboard.instantiateViewControllerWithIdentifier("PasswordFormTableViewController") as PasswordFormTableViewController
    }
}

class PasswordFormTableViewController: UITableViewController {
    
    @IBOutlet weak var editButtonView: UIView!
    
    private weak var editButton: EditButtonViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEditButton()
    }
    
    private func setupEditButton() {
        if editButton != nil { return }
        editButton = EditButtonStoryBoard().viewController
        self.showContainerViewController(editButton, parentView: editButtonView)
    }
}
