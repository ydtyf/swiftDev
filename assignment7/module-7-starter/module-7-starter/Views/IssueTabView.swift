//
//  IssueTabView.swift
//  module-7-starter
//
//  Created by 宰英祺 on 2023/2/21.
//

import SwiftUI

struct IssueTabView: View {
    init(state: String, targetIssue: [GitHubIssue]) {
        // from assignment3
        // https://pacugindre.medium.com/customizing-swiftui-navigation-bar-8369d42b8805
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0),
            .foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().tintColor = .white
        appearance.backgroundColor = .systemBlue
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        self.state = state
        self.targetIssues = targetIssue
    }
    
    @State private var state: String
    var targetIssues: [GitHubIssue]
    var appearance = UINavigationBarAppearance()
    
    var body: some View {
        NavigationView {
            // from teacher's sample code
            List(targetIssues) { issue in

                NavigationLink(destination: IssueDetail(theIssue: issue, imageGrab: ImageGrab(url: issue.user.avatarUrl ?? ""))) {
                    
                    if state == "open" {
                        OpeenIssueTabView(theIssue: issue)
                    } else {
                        ClosedIssueTabView(theIssue: issue)
                    }
                }
            }
            .navigationBarTitle(state.capitalized + " Issues", displayMode: .large )
        }
    }
}

struct IssueTabView_Previews: PreviewProvider {
    static var previews: some View {
        IssueTabView(state: "open", targetIssue: GitHubIssues().openIssues)
    }
}


