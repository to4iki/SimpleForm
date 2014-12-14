//
//  ConfirmViewController.swift
//  SimpleForm
//
//  Created by to4iki on 12/14/14.
//  Copyright (c) 2014 to4iki. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Confirm"
        navigationItem.setHidesBackButton(true, animated: false)
        showDialog()
    }
    
    func showDialog() {
        Dialog.alert(
            self,
            title: "Confirm",
            message: "Poling...",
            buttonTitle: "Cancel",
            handler: { () in
                self.pushToMainViewController()
            }
        )
    }
    
    func pushToMainViewController() {
        navigationController?.pushViewController(MainStoryBoard().mainViewController, animated: true)
    }
}
