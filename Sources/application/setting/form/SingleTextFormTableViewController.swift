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
    
    init(mode: SettingMode) {
        self.storyboard = UIStoryboard(name: "SingleTextForm", bundle: NSBundle(forClass: SingleTextFormTableViewController.self))
        self.viewController =
            self.storyboard.instantiateViewControllerWithIdentifier("SingleTextFormTableViewController") as SingleTextFormTableViewController
        
        self.viewController.settingMode = mode
    }
}

class SingleTextFormTableViewController: UITableViewController, EditButtonDataSource, EditButtonDelegate {
    
    @IBOutlet private weak var anyTextField: UITextField!    
    @IBOutlet weak var editButtonView: UIView!
    
    var settingMode: SettingMode!
    
    var scope = SettingFormViewScope()
    
    var context: SettingFormViewScope {
        return scope
    }
    
    private weak var editButton: EditButtonViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupEditButton()
    }
    
    private func setupLayout() {
        navigationItem.title = settingMode.toNavigationTitle()
        anyTextField.placeholder = settingMode.textFieldPlaceholder
    }
    
    private func setupEditButton() {
        if editButton != nil { return }
        editButton = EditButtonStoryBoard().viewController
        editButton.delegate = self
        editButton.dataSource = self
        self.showContainerViewController(editButton, parentView: editButtonView)
    }
    
    func execSunccessEvent() {}
    func execErrorEvent(error: NSError) {}
}