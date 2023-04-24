//
//  GithubFunctions.swift
//  module-7-starter
//
//  Created by 宰英祺 on 2023/2/21.
//

import Foundation
import UIKit

// From assignment3
func dateChange(theDate: String?) -> String {
    let formatterInput = DateFormatter()
    formatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let formatterOutput = DateFormatter()
    formatterOutput.locale = Locale(identifier: "en_US")
    formatterOutput.dateStyle = .long
    
    guard let trueDate = theDate else {return "No date"}
    guard let date = formatterInput.date(from: trueDate) else {return "error formate, origin date is: \(trueDate)"}
    let prettyDate = formatterOutput.string(from: date)
    return prettyDate
}


// Get Image
class ImageGrab: ObservableObject {
    // Use this struct to update the placeholder after downloading
    @Published var userImage: UIImage = UIImage(systemName: "swift")!
    var url : String = ""
    
    init(url: String) {
        self.url = url
        createImage()
    }
    
    func createImage(){
        // from assignment6
        getImage ( url: self.url, completion: { (image, error) in
            guard let image = image, error == nil else {
                print(error ?? "")
                return
            }
            self.userImage = image
        })
    }
    
    // from assignment6, downloading only one image. No cache here
    func getImage(url: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let url=URL(string: url)!
        let session = URLSession.shared
        
        let task=session.dataTask(with:url as URL,completionHandler:{(data,response,error)->Void in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {completion(nil, error)}
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image, nil)
                }
            }else{
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        })
        task.resume()
    }
}
