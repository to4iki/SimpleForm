//
//  EditButtonViewController.swift
//  SimpleForm
//
//  Created by to4iki on 1/12/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

import Foundation

final class EditButtonStoryBoard {
    
    let storyboard: UIStoryboard
    let viewController: EditButtonViewController
    
    init() {
        self.storyboard = UIStoryboard(name: "EditButton", bundle: NSBundle(forClass: EditButtonViewController.self))
        self.viewController =
            self.storyboard.instantiateViewControllerWithIdentifier("EditButtonViewController") as EditButtonViewController
    }
}

protocol EditButtonDelegate: class {
    func execSunccessEvent()
    func execErrorEvent(error: NSError)
}

protocol EditButtonDataSource: class {
    var settingMode: SettingMode! { get }
    var context: SettingFormViewScope { get }
}

class EditButtonViewController: UIViewController {
    
    @IBOutlet weak var editButton: UIButton!
    
    weak var delegate: EditButtonDelegate?
    weak var dataSource: EditButtonDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHandler()
    }
    
    override func viewDidLayoutSubviews() {
        drawBorder()
    }
    
    private func drawBorder() {
        self.view.layer.borderWidth = 1.0
        self.view.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
    }
    
    private func setupHandler() {
        editButton.addTarget(self, action: "onValidate", forControlEvents: .TouchUpInside)
    }
    
    func onValidate() {
        // dummy
        // 1. validation APIアクセスなどerrorチェック
        // 2. 成功なら、dalegate.success (edit系のAPI実施)
    }
}