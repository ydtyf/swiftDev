//
//  ClosedIssueTabView.swift
//  module-7-starter
//
//  Created by 宰英祺 on 2023/2/21.
//

import SwiftUI

struct ClosedIssueTabView: View {
    var theIssue: GitHubIssue
    
    var body: some View {
        HStack{
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .foregroundColor(Color.green)
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

struct ClosedIssueTabView_Previews: PreviewProvider {
    static var previews: some View {
        ClosedIssueTabView(theIssue: GitHubIssue(title: "1fndsiu afhkjcba sjkfekjbffbai usfaksjcfaksj", id: 1, createdAt: "3", body: "4", state: "closed", user:  GitHubUser(login: "abc", avatarUrl: "https://avatars.githubusercontent.com/u/36283618?s=400&u=65977e1453050938e68ace69a3fc7219a87e717f&v=4")))
    }
}
