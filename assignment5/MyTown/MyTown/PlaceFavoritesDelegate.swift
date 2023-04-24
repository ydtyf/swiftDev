//
//  PlaceFavoritesDelegate.swift
//  MyTown
//
//  Created by 宰英祺 on 2023/2/7.
//

import Foundation

protocol PlacesFavoritesDelegate: AnyObject {
    
    // Notice it only declares a requirement, we don't need to inplement anything here
    // Copy from teacher's example
    func favoritePlace(name: String) -> Void
}
