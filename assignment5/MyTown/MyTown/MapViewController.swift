//
//  MapViewController.swift
//  MyTown
//
//  Created by 宰英祺 on 2023/2/7.
//

import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView! {
        didSet {mapView.delegate = self}
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var markButton: UIButton!
    @IBOutlet weak var desciptionLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var curTitle: String?
    var curLocation: CLLocationCoordinate2D?
    var curAnnotation: Place?
    
    
    func setUpBackground(){
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.mapView.delegate = self
        self.mapView.showsCompass = false
        self.mapView.pointOfInterestFilter = .excludingAll
        
        // start location
        self.mapView.region = DataManager.sharedInstance.loadRegion()!
        
        // places all the marks on the map
        self.mapView.addAnnotations(DataManager.sharedInstance.loadAnnotations()!)
        self.mapView.register(PlaceMarkerView.self, forAnnotationViewWithReuseIdentifier:MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        curAnnotation = DataManager.sharedInstance.loadFirstAnnotations()
        nameLabel.text = curAnnotation?.title
        desciptionLabel.text = curAnnotation?.subtitle
        curLocation = curAnnotation?.coordinate
        
        markButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        markButton.setImage(UIImage(systemName: "star"), for: .normal)
        markButton.addTarget(self, action: #selector(markButtonTapped), for: UIControl.Event.touchUpInside)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: UIControl.Event.touchUpInside)
        
        // Do any additional setup after loading the view.
    }

    // https://developer.apple.com/documentation/uikit/uisheetpresentationcontroller
    func showMyViewControllerInACustomizedSheet() {
        let PlaceViewController = self.storyboard?.instantiateViewController(identifier: "FavoritesViewController") as! PlaceViewController
        PlaceViewController.delegate = self
        if let sheet = PlaceViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        present(PlaceViewController, animated: true, completion: nil)
    }

    @objc func favoriteButtonTapped(_ button: UIButton) {
        showMyViewControllerInACustomizedSheet()
    }
    
    @objc func markButtonTapped(_ button: UIButton) {
        if button.isSelected == false{
            // 强制转换
            // force change
            DataManager.sharedInstance.addFavorite(nameLabel.text!, curLocation!)
            markButton.isSelected = true
        } else {
            DataManager.sharedInstance.removeFavorite(nameLabel.text!)
            markButton.isSelected = false
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        nameLabel.text = (view.annotation?.title)!
        desciptionLabel.text = (view.annotation?.subtitle)!
        curLocation = view.annotation?.coordinate
        markButton.isSelected = DataManager.sharedInstance.isFavorite(nameLabel.text!)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Place {
            let identifier = "CustomPin"

            // Create a new view
            var view: MKMarkerAnnotationView

            // Deque an annotation view or create a new one
            // https://stackoverflow.com/questions/3663563/how-to-automatically-display-title-subtitle-on-map-annotation-pin
            // Remove title and subtitle
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                dequeuedView.subtitleVisibility = .hidden
                view = dequeuedView
            } else {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = false
                view.subtitleVisibility = .hidden
                view.glyphText = "❤︎"
            }
            return view
        }
        return nil
        
    }

}

// finish the protocol requirement here to comply, and it will be used in the connection
// send the name to the list


extension MapViewController: PlacesFavoritesDelegate {
    func favoritePlace(name: String) {
        
        curLocation = DataManager.sharedInstance.locationFromName(name)
        let viewRegion = MKCoordinateRegion.init(center: curLocation!, latitudinalMeters: 160*5, longitudinalMeters: 160*5)
        mapView.setRegion(viewRegion, animated: true)
        nameLabel.text = name
        // MARK: - This is a little complex to change, teacher's app did not solve it.
        desciptionLabel.text = ""
        markButton.isSelected = DataManager.sharedInstance.isFavorite(nameLabel.text!)
    }
}
