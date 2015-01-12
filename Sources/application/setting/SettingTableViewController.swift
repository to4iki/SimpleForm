//
//  SettingTableViewController.swift
//  SimpleForm
//
//  Created by to4iki on 1/12/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

import UIKit

final class SettingStoryBoard {
    
    let storyboard: UIStoryboard
    let viewController: SettingTableViewController
    
    init() {
        self.storyboard = UIStoryboard(name: "Setting", bundle: NSBundle(forClass: SettingTableViewController.self))
        self.viewController =
            self.storyboard.instantiateViewControllerWithIdentifier("SettingTableViewController") as SettingTableViewController
    }
}

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        cell.accessoryType = .DisclosureIndicator
        cell.selectionStyle = .Default
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mode = SettingMode.getInstanceByIndexPath(indexPath)
        openForm(mode!)
    }
    
    private func openForm(mode: SettingMode) {
        switch mode {
        case .Password: navigationController?.pushViewController(PasswordFormStoryBoard().viewController, animated: true)
        default: navigationController?.pushViewController(SingleTextFormStoryBoard(mode: mode).viewController, animated: true)  
        }
    }
}
