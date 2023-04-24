//
//  IssueDetail.swift
//  module-7-starter
//
//  Created by 宰英祺 on 2023/2/21.
//

import SwiftUI

struct IssueDetail: View {
    
    // Example photo is my github avatar
    var theIssue : GitHubIssue
    @ObservedObject var imageGrab: ImageGrab
    
    var body: some View {
        VStack(alignment: .leading){
            Text(theIssue.title ?? "Title Missing")
                .font(.largeTitle)
                .fontWeight(.bold)
                
            Image(uiImage: imageGrab.userImage)
                .resizable()
                .frame(width: 100,height: 100)
                .mask(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.black, lineWidth: 5)
                )
            HStack{
                VStack(alignment: .leading){
                        Text("User: @"+theIssue.user.login)
                    Text("Data: " + dateChange(theDate: theIssue.createdAt) )
                }
                Spacer()
                
                Image(systemName: "tray.full.fill")
                    .resizable()
                    .foregroundColor(Color.red)
                    .frame(width:50, height:50)
                    
            }
            Text("Description")
                .fontWeight(.bold)
                .font(.title)
                .frame(height: 50)
            ScrollView{
                Text(theIssue.body ?? "No text for this issue")
            }
        }
        .padding(.horizontal, 20)
        
    }
}

struct IssueDetail_Previews: PreviewProvider {
    static var previews: some View {
        IssueDetail(theIssue: GitHubIssue(title: "It is a good day and let'go hiking!", id: 141234, createdAt: "2023-02-21T12:33:05Z", body: "ContentView is the root view for your project.\nAdd a TabView with two tabs, one named and another named . Display an icon for each tab and change the TabView's accent color to something other than blue.\nCustomize the navigation bar color. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", state: "open", user:  GitHubUser(login: "Yingqi", avatarUrl: "https://avatars.githubusercontent.com/u/36283618?s=400&u=65977e1453050938e68ace69a3fc7219a87e717f&v=4")), imageGrab: ImageGrab(url: "https://avatars.githubusercontent.com/u/36283618?s=400&u=65977e1453050938e68ace69a3fc7219a87e717f&v=4"))
    }
}
