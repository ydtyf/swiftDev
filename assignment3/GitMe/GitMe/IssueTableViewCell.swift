//
//  IssueTableViewCell.swift
//  GitMe
//
//  Created by 宰英祺 on 2023/1/24.
//

import UIKit

class IssueTableViewCell: UITableViewCell {

    @IBOutlet weak private var TitleLabel: UILabel!
    @IBOutlet weak private var Picture: UIImageView!
    @IBOutlet weak private var AuthorLabel: UILabel!
    
    
    var issue: GithubIssue! {
        didSet {
            Picture?.image = issue.state?.image
            Picture.tintColor = issue.state?.systemColor
            TitleLabel.text = issue.title
            AuthorLabel.text = "@" + issue.user.login
            
        }
    }
    // MARK: - 两种方法来初始化private的参数
    // Two ways to initialize 
//    func configure(with issue: GithubIssue) {
//        Picture?.image = issue.state?.image
//        Picture.tintColor = issue.state?.systemColor
//        TitleLabel.text = issue.title
//        AuthorLabel.text = "@" + issue.user.login
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    


}
