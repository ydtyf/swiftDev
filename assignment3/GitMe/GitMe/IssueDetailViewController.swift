//
//  IssueDetailViewController.swift
//  GitMe
//
//  Created by 宰英祺 on 2023/1/24.
//

import UIKit

class IssueDetailViewController: UIViewController {

    @IBOutlet weak private var TitleIssue: UILabel!
    @IBOutlet weak private var IssueAuthor: UILabel!
    @IBOutlet weak private var DataIssue: UILabel!
    @IBOutlet weak private var IssueMainTaxt: UITextView!
    @IBOutlet weak private var IssueStatePicture: UIImageView!
    
    var selectedissue : GithubIssue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Learn from https://riptutorial.com/ios/example/5022/linebreakmode
        TitleIssue?.text = selectedissue?.title
        //TitleIssue.adjustsFontSizeToFitWidth = true
        TitleIssue.numberOfLines = 2
        
        IssueAuthor?.text = "@" + (selectedissue?.user.login ?? "Anonymous")
        DataIssue?.text = selectedissue?.createdAt
        IssueStatePicture?.image = selectedissue?.state?.image
        IssueStatePicture.tintColor = selectedissue?.state?.systemColor
        
        // Some of the issue has no body text, so I set a default version
        IssueMainTaxt?.text = selectedissue?.body ?? "No text for this issue"
        
    }
}
