//
//  OpenIssueViewController.swift
//  GitMe
//
//  Created by 宰英祺 on 2023/1/24.
//

import UIKit

class OpenIssueViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerID = .open
        appreanceSetting()
        displayGitHubIssues(controllerID: controllerID ?? .open)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenCell", for: indexPath) as! IssueTableViewCell
        
        let issue = controllerID?.issuesOf?[indexPath.row]
        cell.issue = issue
        
        return cell
    }
}
