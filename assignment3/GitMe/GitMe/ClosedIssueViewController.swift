//
//  ClosedIssueViewController.swift
//  GitMe
//
//  Created by 宰英祺 on 2023/1/24.
//

import UIKit

class ClosedIssueViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        controllerID = .closed
        appreanceSetting()
        displayGitHubIssues(controllerID: controllerID ?? .closed)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClosedCell", for: indexPath) as! IssueTableViewCell
        let issue = controllerID?.issuesOf?[indexPath.row]
        cell.issue = issue
        
        return cell
    }
}
