//
//  Animal.swift
//  zoo
//
//  Created by 宰英祺 on 2023/1/15.
//

import Foundation
import UIKit

class Animal {
    let name: String
    let species: String
    let age: Int
    let image: UIImage
    // let soundPath: String
    let soundPath: NSDataAsset
    
    init(theName:String, theSpecies:String, theAge:Int, theImage: UIImage, theSoundPath: NSDataAsset){
        name = theName
        species = theSpecies
        age = theAge
        image = theImage
        soundPath = theSoundPath
    }
}

extension Animal: CustomStringConvertible{
    var description: String {
        return "name = \(name), species = \(species), age = \(age)"
    }
    
}
