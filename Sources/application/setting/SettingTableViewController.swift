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

enum AccountSettingMode: String {
    
    case NickName = "nickName"
    case Password = "password"
    case Sex = "sex"
    case Birthday = "birthday"
    
    private var suffix: String {
        switch self {
        case .Sex, .Birthday: return "create"
        default: return "edit"
        }
    }
    
    var textFieldPlaceholder: String {
        switch self {
        case .Sex, .Birthday: return self.rawValue
        default: return "new \(self.rawValue)"
        }
    }
    
    func toNavigationTitle() -> String {
        return "\(self.rawValue) \(suffix)"
    }
    
    static func getInstanceByIndexPath(indexPath: NSIndexPath) -> AccountSettingMode? {
        switch (indexPath.section, indexPath.row) {
        case (0, 0): return .NickName
        case (0, 1): return .Password
        case (1, 0): return .Sex
        case (1, 1): return .Birthday
        default: return nil
        }
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
        let mode = AccountSettingMode.getInstanceByIndexPath(indexPath)
        openForm(mode!)
    }
    
    private func openForm(mode: AccountSettingMode) {
        switch mode {
        case .Password: navigationController?.pushViewController(PasswordFormStoryBoard().viewController, animated: true)
        default: navigationController?.pushViewController(SingleTextFormStoryBoard(mode: mode).viewController, animated: true)  
        }
    }
}
