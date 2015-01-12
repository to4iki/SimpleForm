//
//  SingleTextFormTableViewController.swift
//  SimpleForm
//
//  Created by to4iki on 1/12/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

import UIKit

final class SingleTextFormStoryBoard {
    
    let storyboard: UIStoryboard
    let viewController: SingleTextFormTableViewController
    
    init(mode: AccountSettingMode) {
        self.storyboard = UIStoryboard(name: "SingleTextForm", bundle: NSBundle(forClass: SingleTextFormTableViewController.self))
        self.viewController =
            self.storyboard.instantiateViewControllerWithIdentifier("SingleTextFormTableViewController") as SingleTextFormTableViewController
        
        self.viewController.mode = mode
    }
}

class SingleTextFormTableViewController: UITableViewController {
    
    @IBOutlet private weak var anyTextField: UITextField!
    
    private var mode: AccountSettingMode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = mode.toNavigationTitle()
        anyTextField.placeholder = mode.textFieldPlaceholder
    }
}