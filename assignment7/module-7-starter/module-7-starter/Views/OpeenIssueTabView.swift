//
//  OpeenIssueTabView.swift
//  module-7-starter
//
//  Created by 宰英祺 on 2023/2/21.
//

import SwiftUI

struct OpeenIssueTabView: View {
    var theIssue: GitHubIssue
    var body: some View {
        HStack{
            Image(systemName: "tray.full.fill")
                .resizable()
                .foregroundColor(Color.red)
                .frame(width:50, height:50)
            
            VStack(alignment: .leading) {
                Text(theIssue.title ?? "Title Missing")
                    .fontWeight(.bold)
                    .lineLimit(2)
                
                Text("@"+theIssue.user.login)
                    .lineLimit(1)
            }
        }
    }
}

struct OpeenIssueTabView_Previews: PreviewProvider {
    static var previews: some View {
        OpeenIssueTabView(theIssue: GitHubIssue(title: "Have a nice day!", id: 1, createdAt: "123", body: "456", state: "open", user:  GitHubUser(login: "Yingqi", avatarUrl: "https://avatars.githubusercontent.com/u/36283618?s=400&u=65977e1453050938e68ace69a3fc7219a87e717f&v=4")))
    }
}
