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
    
}

protocol EditButtonDataSource: class {
    
}

class EditButtonViewController: UIViewController {
    
    @IBOutlet weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        drawBorder()
    }
    
    private func drawBorder() {
        self.view.layer.borderWidth = 1.0
        self.view.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
    }
}