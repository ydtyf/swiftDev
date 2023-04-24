//
//  ContentView.swift
//  module-7-starter
//
//  Created by Andrew Binkowski on 2/22/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var githubIssues: GitHubIssues
    
    var body: some View {
        TabView {
            IssueTabView(state: "open", targetIssue: githubIssues.openIssues)
                .tabItem {
                    Image(systemName: "tray.full.fill")
                        .foregroundColor(.red)
                    Text("Open Issues")
                }
                
            IssueTabView(state: "closed", targetIssue: githubIssues.closedIssues)
                .tabItem {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Closed Issues")
                }
        }
        .tint(.orange)
        // https://developer.apple.com/documentation/swiftui/view/tint(_:)-23xyq
        // why cannot give each a different color when selecting different bar items?
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(githubIssues: GitHubIssues())
    }
}

