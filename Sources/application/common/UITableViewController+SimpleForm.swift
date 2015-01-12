//
//  UITableViewController+SimpleForm.swift
//  SimpleForm
//
//  Created by to4iki on 1/12/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

import Foundation
import Snap

extension UITableViewController {
    
    func showContainerViewController(container: UIViewController, parentView: UIView) {
        self.addChildViewController(container)
        parentView.addSubview(container.view)
        fixLayout2superview(container.view)
        container.didMoveToParentViewController(self)
    }
    
    func hideContainerViewController(container: UIViewController) {
        container.willMoveToParentViewController(nil)
        container.view.removeFromSuperview()
        container.removeFromParentViewController()
    }
    
    private func fixLayout2superview(view: UIView) {
        view.snp_makeConstraints { make in
            make.edges.equalTo(self.view); return
        }
    }
}