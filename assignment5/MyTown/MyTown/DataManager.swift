//
//  DataManager.swift
//  MyTown
//
//  Created by 宰英祺 on 2023/2/7.
//

import Foundation
import CoreLocation
import MapKit

// Learn from teacher'e example
public class DataManager {
    // Use singleton
    
    public static let sharedInstance = DataManager()
    // Set a dictionary to store the favorite places
    var bestPlace: [String: CLLocationCoordinate2D]?
    
    // 关闭其他初始化方式
    fileprivate init() {}
    
    // https://stackoverflow.com/questions/24096293/assign-value-to-optional-dictionary-in-swift
    // Shocked to know optional dictionary != dictionary, and a nil one cannot add anything!
    func addFavorite(_ title:String, _ currentCLLocationCoordinate2D:CLLocationCoordinate2D) {
        if bestPlace != nil {
            bestPlace![title] = currentCLLocationCoordinate2D as CLLocationCoordinate2D?
            print(currentCLLocationCoordinate2D)
        } else {
            bestPlace = [title: currentCLLocationCoordinate2D]
        }
    }

    func isFavorite(_ favorite: String) -> Bool {
        if bestPlace != nil {
            return (bestPlace!.keys.contains(favorite))
        }
        return false
    }

    func removeFavorite(_ favorite: String) {
        bestPlace?.removeValue(forKey: favorite)

    }

    func favorites() -> [String] {
        if let allKey = bestPlace?.keys  {
            return Array(allKey)
        }
        return []
    }

    func locationFromName(_ name:String) -> CLLocationCoordinate2D {
        // Must check existence first
        return (bestPlace?[name])!
    }
    
    // Load data from Plist, which is the start point
    // 从plist调取初始化位置
    func loadRegion() ->MKCoordinateRegion? {
        if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!) {
            if let region = plist["region"] as? [NSNumber] {
                let coordinate = CLLocationCoordinate2D(latitude: region[0].doubleValue, longitude: region[1].doubleValue)
                let span = MKCoordinateSpan.init(latitudeDelta: region[2].doubleValue, longitudeDelta: region[3].doubleValue)
                return MKCoordinateRegion.init(center: coordinate, span: span)
            }
        }
        return nil
    }
    
    func loadFirstAnnotations() -> Place? {
        if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!) {
            if let places = plist["places"] as? [[String : AnyObject]] {
                // 强制返回了第1个而没有检测是否是空
                return Place.places(fromDictionaries: places)[0]
            }
        }
        return nil
    }
    
    
    func loadAnnotations() -> [Place]? {
        if let plist = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!) {
            if let places = plist["places"] as? [[String : AnyObject]] {
                return Place.places(fromDictionaries: places)
            }
        }
        return nil
    }
}
