//
//  GithubClient.swift
//  module-7-github-issues-swiftui
//
//  Created by Andrew Binkowski on 2/22/22.
//

import Foundation

class GitHubIssues: ObservableObject {
    @Published var openIssues: [GitHubIssue] = []
    @Published var closedIssues: [GitHubIssue] = []
    
    init() {
        let url = URL(string: "https://api.github.com/repos/revanced/revanced-manager/issues?state=all")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let issues = try? decoder.decode([GitHubIssue].self, from: data)
            
            DispatchQueue.main.async {
                if let issues = issues {
                    self.openIssues = issues.filter({ $0.state == "open" })
//                    print(self.openIssues)
                    self.closedIssues = issues.filter({ $0.state == "closed" })
                }
            }
        }
        task.resume()
    }
}
