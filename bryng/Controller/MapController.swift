//
//  BetterMapController.swift
//  bryng
//
//  Created by Florian Woelki on 10.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

struct Route {
    var destination: CLLocationCoordinate2D
    var distance: Double
}

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    fileprivate var routesDistances = [Route]()
    
    fileprivate var stores = [Store]()
    
    fileprivate var mapView: MKMapView!
    fileprivate let locationManager = CLLocationManager()
    fileprivate let regionInMeters: Double = 1000
    
    fileprivate var directionsArray: [MKDirections] = []
    
    private var navigationFixedButtonSelected = false
    private let navigationFixedButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "navigation_arrow"), for: .normal)
        btn.backgroundColor = .white
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowRadius = 0.0
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private let mapStoreInformationView = MapStoreInformationView()
    private let mapStoreInformationViewHeight: CGFloat = 250
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GraphQLService.shared.fetchAllStores { (stores) in
            self.stores = stores
            self.addStoreAnnotations()
        }
        
        setupMapView()
        checkLocationServices()
        setupLayout()
        setupMapStoreInformationView()
        
        mapStoreInformationView.frame = .init(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: mapStoreInformationViewHeight)
        self.view.addSubview(mapStoreInformationView)
    }
    
    private func setupMapStoreInformationView() {
        mapStoreInformationView.didClickOnGoTo = {
            guard let viewController = self.tabBarController?.viewControllers?[1] as? UINavigationController else { return }
            
            guard let allStoresController = viewController.topViewController as? AllStoresController else { return }
            
            allStoresController.tabBarController?.selectedIndex = 1
            allStoresController.goToStoreController(name: self.mapStoreInformationView.store!.name)
        }
    }
    
    private func setupLayout() {
        mapView.addSubview(navigationFixedButton)
        navigationFixedButton.constrainWidth(constant: 48)
        navigationFixedButton.constrainHeight(constant: 48)
        navigationFixedButton.anchor(top: nil, leading: nil, bottom: mapView.bottomAnchor, trailing: mapView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 100, right: 16))
        
        navigationFixedButton.addTarget(self, action: #selector(didTapOnNavigationFixed), for: .touchUpInside)
    }
    
    @objc private func didTapOnNavigationFixed() {
        if !navigationFixedButtonSelected {
            navigationFixedButton.setImage(#imageLiteral(resourceName: "navigation_arrow_selected"), for: .normal)
            navigationFixedButtonSelected = true
            centerViewOnUserLocation()
        } else {
            navigationFixedButton.setImage(#imageLiteral(resourceName: "navigation_arrow"), for: .normal)
            navigationFixedButtonSelected = false
        }
    }
    
    fileprivate func setupMapView() {
        mapView = MKMapView()
        mapView.delegate = self
        
        mapView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        view.addSubview(mapView)
    }
    
    fileprivate func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    fileprivate func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
        } else {
            AlertUtil.showBasicAlertWithDelay(viewController: self, title: "Bitte beachten!", message: "Die App funktioniert nicht richtig, wenn die Standortlokalisierung deaktiviert ist")
        }
    }
    
    fileprivate func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            AlertUtil.showBasicAlertWithDelay(viewController: self, title: "Bitte beachten!", message: "Die App funktioniert nicht richtig, wenn die Standortlokalisierung deaktiviert ist")
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            AlertUtil.showBasicAlertWithDelay(viewController: self, title: "Bitte beachten!", message: "Die App funktioniert nicht richtig, wenn die Standortlokalisierung deaktiviert ist")
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    fileprivate func drawDirections(to toLocation: CLLocationCoordinate2D?) {
        guard let fromLocation = locationManager.location?.coordinate else {
            AlertUtil.showBasicAlertWithDelay(viewController: self, title: "Achtung!", message: "Es wurde keine Location für dich gefunden. Bitte starte die App neu!")
            return
        }
        
        guard let toLocation = toLocation else { return }
        
        let request = createDirectionsRequest(from: fromLocation, to: toLocation)
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        
        directions.calculate { (response, error) in
            if let error = error {
                print("Something went wrong: \(error)")
                return
            }
            
            guard let response = response else {
                AlertUtil.showBasicAlertWithDelay(viewController: self, title: "Achtung!", message: "Es wurde keine Route gefunden.")
                return
            }
            
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
            }
        }
    }
    
    fileprivate func addStoreAnnotations() {
        for store in stores {
            let groceryShop = GroceryShop(title: store.name, locationName: nil, coordinate: CLLocationCoordinate2D(latitude: store.latitude, longitude: store.longitude))
            mapView.addAnnotation(groceryShop)
        }
    }
    
    fileprivate func createDirectionsRequest(from fromLocationCoordinate: CLLocationCoordinate2D, to toLocationCoordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let startingLocation = MKPlacemark(coordinate: fromLocationCoordinate)
        let destination = MKPlacemark(coordinate: toLocationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .walking
        request.requestsAlternateRoutes = false
        return request
    }
    
    fileprivate func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    fileprivate func resetMapView(withNew directions: MKDirections?) {
        mapView.removeOverlays(mapView.overlays)
        
        if let directions = directions {
            directionsArray.append(directions)
        }
        
        let _ = directionsArray.map { $0.cancel() }
        directionsArray.removeAll()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let userCoordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        
        drawDirections(to: view.annotation?.coordinate)
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        guard let endAnnotation = view.annotation else { return }
        let endLocation = CLLocation(latitude: endAnnotation.coordinate.latitude, longitude: endAnnotation.coordinate.longitude)
        
        let distance = userLocation.distance(from: endLocation)
        var distanceOutput = ""
        if distance < 1000 {
            distanceOutput = "\(Double(round(100 * distance) / 100))m"
        } else {
            distanceOutput = "\(Double(round(distance)))km"
        }
        
        mapStoreInformationView.distanceLabel.text = distanceOutput
        let store = stores.filter({$0.latitude == endLocation.coordinate.latitude && $0.longitude == endLocation.coordinate.longitude})[0]
        mapStoreInformationView.store = store
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.navigationFixedButton.transform = CGAffineTransform(translationX: 0, y: -(self.mapStoreInformationViewHeight / 2 + 40))
            self.mapStoreInformationView.transform = CGAffineTransform(translationX: 0, y: -self.mapStoreInformationViewHeight)
        }, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        resetMapView(withNew: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.navigationFixedButton.transform = CGAffineTransform(translationX: 0, y: 0)
            self.mapStoreInformationView.transform = CGAffineTransform(translationX: 0, y: self.mapStoreInformationViewHeight)
        }, completion: nil)
    }
    
    private var firstTimeLoaded = true
    private var latestTrackedLocation: CLLocationCoordinate2D!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        if navigationFixedButtonSelected || firstTimeLoaded {
            centerViewOnUserLocation()
            if firstTimeLoaded {
                latestTrackedLocation = locations[0].coordinate
                saveLocation(latitude: latestTrackedLocation.latitude, longitude: latestTrackedLocation.longitude)
            }
            
            firstTimeLoaded = false
            
            let distance = calc(lat1: latestTrackedLocation.latitude, lon1: latestTrackedLocation.longitude, lat2: locations[0].coordinate.latitude, lon2: locations[0].coordinate.longitude)
            if distance >= 5 {
                latestTrackedLocation = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
                saveLocation(latitude: latestTrackedLocation.latitude, longitude: latestTrackedLocation.longitude)
            }
        }
    }
    
    private func saveLocation(latitude: Double, longitude: Double) {
        GraphQL.shared.getAuthorizedApollo(token: nil) { (apollo) in
            let addLocationMutation = AddLocationMutation(latitude: latitude, longitude: longitude)
            
            apollo.perform(mutation: addLocationMutation) { result, error in
                if let error = error {
                    print(error)
                    return
                }
                
                guard let _ = result?.data?.addLocation else {
                    print("Could not save location in database!")
                    return
                }
            }
        }
    }
    
    private func calc(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        let R = 6378.137; // Radius of earth in KM
        let dLat = lat2 * Double.pi / 180 - lat1 * Double.pi / 180;
        let dLon = lon2 * Double.pi / 180 - lon1 * Double.pi / 180;
        let a = sin(dLat / 2) * sin(dLat / 2) +
            cos(lat1 * Double.pi / 180) * cos(lat2 * Double.pi / 180) *
            sin(dLon / 2) * sin(dLon / 2);
        let c = 2 * atan2(sqrt(a), sqrt(1 - a));
        let d = R * c;
        return d * 1000; // meters
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
 
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = #colorLiteral(red: 0.9706280828, green: 0.3376097977, blue: 0.3618901968, alpha: 1)
        renderer.lineWidth = 5.0
        renderer.lineDashPattern = [5, 10]
        return renderer
    }
    
}
