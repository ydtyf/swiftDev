//
//  BaseTableViewController.swift
//  GitMe
//
//  Created by 宰英祺 on 2023/2/4.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    var controllerID: State?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        let refreshTitle = NSAttributedString(string: "Now refresh")
        refreshControl.attributedTitle = refreshTitle
        refreshControl.addTarget(self,
                                 action: #selector(refresh(sender:)),
                                 for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        guard let curID = controllerID else {return}
        displayGitHubIssues(controllerID: curID)
        
        sender.endRefreshing()
    }
    
    func displayGitHubIssues(controllerID: State){
        GitHubClient.fetchIssues(state: controllerID) { (issues, error) in

            let formatterInput = DateFormatter()
            formatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let formatterOutput = DateFormatter()
            formatterOutput.locale = Locale(identifier: "en_US")
            formatterOutput.dateStyle = .long
            guard let issues = issues, error == nil else {
                print(error!)
                return
            }
            
            var stack: [GithubIssue] = []
            
            for issue in issues {
                guard let date = formatterInput.date(from: issue.createdAt) else {return}
                var tem = issue
                let prettyDate = formatterOutput.string(from: date)
                tem.createdAt = prettyDate
                stack.append(tem)
                //controllerID?.issuesOf?.append(tem)
            }
            
            // (关于这个enum读入只有只读的问题)
            // MARK: Translation: Here controllerID?.issuesOf can only give a read-only IssuesOfOpen
            
            // how to solve it to make codes more Concise?
            if controllerID == .open {
                IssuesOfOpen = stack
            } else {
                IssuesOfClosed = stack
            }
            
            self.tableView.reloadData()
        }
    }
    
    func appreanceSetting() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
            .foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white

        appearance.backgroundColor = controllerID?.color
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllerID?.issuesOf?.count ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let currentIndex: IndexPath = tableView!.indexPathForSelectedRow!
        if (segue.identifier == controllerID?.identifier) {
            let vc = segue.destination as! IssueDetailViewController
            vc.selectedissue = controllerID?.issuesOf?[currentIndex.row]
        }
    }
    
}
