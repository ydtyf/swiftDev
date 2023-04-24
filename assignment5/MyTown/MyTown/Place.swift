//
//  Place.swift
//  MyTown
//
//  Created by 宰英祺 on 2023/2/7.
//

// Learn from teacher's video
import MapKit

// 这个的作用是定义标注在地图上的大头针上显示的文字内容
class Place: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    //var type: Int?
    
    init(_ title: String?,_ subtitle: String?,_ coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
    
    
    // https://stackoverflow.com/questions/24021950/how-do-i-put-different-types-in-a-dictionary-in-the-swift-language
    // Use AnyObject to replace the NSNumber
    class func places(fromDictionaries dictionaries: [[String: AnyObject]]) -> [Place] {
        let places = dictionaries.map { item -> Place in
            let place = Place(
                              item["name"] as? String,
                              item["description"] as? String,
                              CLLocationCoordinate2DMake(item["lat"]!.doubleValue, item["long"]!.doubleValue))
            //place.type = item["type"]!.intValue
            return place
        }
        return places
    }
    
}
