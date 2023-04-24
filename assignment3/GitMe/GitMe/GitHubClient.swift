//
//  GitHubClient.swift
//  GitMe
//
//  Created by 宰英祺 on 2023/1/24.
//

import Foundation
import UIKit


struct GithubIssue: Codable {
    let title: String?
    var createdAt: String
    let body: String?
    let user: GitHubUser
    let state: State?
    // https://stackoverflow.com/questions/46836105/access-enum-inside-struct
    
}

struct GitHubUser:Codable {
    let login: String
}

var IssuesOfClosed: [GithubIssue] = []
var IssuesOfOpen: [GithubIssue] = []

enum State: String, Codable{
    case open = "open"
    case closed = "closed"
    
    var image: UIImage? {
        switch self {
        case .open:
          return UIImage(systemName: "tray.full.fill")
        case .closed:
          return UIImage(systemName: "checkmark.circle.fill")
        }
      }
    
    var issuesOf: [GithubIssue]? {
        switch self {
        case .open:
            return IssuesOfOpen
        case . closed:
            return IssuesOfClosed
        }
    }
    
    
    var identifier: String? {
        switch self {
        case .open:
            return "toOpenIssue"
        case . closed:
            return "toClosedIssue"
        }
    }
    
    var systemColor: UIColor? {
        switch self {
        case .open:
            return .systemRed
        case .closed:
            return .systemGreen
        }
    }
    
    var color: UIColor? {
        switch self {
        case .open:
            return .red
        case .closed:
            return .green
        }
    }
}
