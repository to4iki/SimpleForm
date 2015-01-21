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

class SettingTableViewController: UITableViewController, DeleteButtonDelegate {
    
    weak var deleteButton: DeleteButtonViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDeleteButton()
    }
    
    private func setupDeleteButton() {
        for subView in childViewControllers {
            switch subView {
            case let subView as DeleteButtonViewController:
                deleteButton = subView
                deleteButton?.delegate = self
            default:
                break
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
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
    
    // MARK: - DeleteButtonDelegate
    
    func onDeleteSuccess() {
        Hud.showSuccessWithStatus(self.view, text: "Success", afterDelay: NSTimeInterval(2.0))
    }
    
    func onDeleteError(error: String) {
        Dialog.alert(self, title: "Error", message: error)
    }
}
