//
//  PlaceMarkerView.swift
//  MyTown
//
//  Created by 宰英祺 on 2023/2/7.
//

import MapKit

class PlaceMarkerView: MKMarkerAnnotationView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var annotation: MKAnnotation? {
          willSet {
            clusteringIdentifier = "Place"
            displayPriority = .defaultLow
            markerTintColor = .systemRed
            glyphImage = UIImage(systemName: "pin.fill")
            }
      }
    
}
