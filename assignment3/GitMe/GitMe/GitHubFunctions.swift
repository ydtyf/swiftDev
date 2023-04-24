//
//  GitHubFunctions.swift
//  GitMe
//
//  Created by 宰英祺 on 2023/2/4.
//

import Foundation
import UIKit

class GitHubClient {
    
    static func fetchIssues(state: State, completion: @escaping ([GithubIssue]?, Error?) -> Void) {
    // Set the URL
    // Learn from https://docs.github.com/en/rest/issues/issues?apiVersion=2022-11-28#list-repository-issues

        let url = URL(string: "https://api.github.com/repos/revanced/revanced-manager/issues?state=\(state.rawValue)")!
    
    // Create a data task
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
      
      guard let data = data, error == nil else {
        // If we are missing data, send back no data with an error
        DispatchQueue.main.async { completion(nil, error) }
        return
      }
      
      // Safely try to decode the JSON to our custom struct
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let releases = try decoder.decode([GithubIssue].self, from: data)

        // If we're successful, send back our releases with no error
        DispatchQueue.main.async { completion(releases, nil) }

      } catch (let parsingError) {
        DispatchQueue.main.async { completion(nil, parsingError) }
      }
    }
    // Start the task (it begins suspended)
    task.resume()
  }
}




