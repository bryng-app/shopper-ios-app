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
    
    fileprivate var mapView: MKMapView!
    fileprivate let locationManager = CLLocationManager()
    fileprivate let regionInMeters: Double = 1000
    
    fileprivate var directionsArray: [MKDirections] = []
    fileprivate var tempBool = true // TODO: Remove
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        checkLocationServices()
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
    
    fileprivate func getDirections() {
        guard let location = locationManager.location?.coordinate else {
            AlertUtil.showBasicAlertWithDelay(viewController: self, title: "Achtung!", message: "Es wurde keine Location für dich gefunden. Bitte starte die App neu!")
            return
        }
        
        let request = createDirectionsRequest(from: location)
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
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
            
            self.addDirectionsAnnotations(userLocation: location)
        }
    }
    
    fileprivate func addDirectionsAnnotations(userLocation: CLLocationCoordinate2D) {
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = userLocation
        userAnnotation.title = "Startpunkt"
        mapView.addAnnotation(userAnnotation)
        
        let rewe = GroceryShop(title: "Norma", locationName: "Heinrich-Grüber-Straße 86, 12621 Berlin", coordinate: CLLocationCoordinate2D(latitude: 52.518827, longitude: 13.596681))
        mapView.addAnnotation(rewe)
    }
    
    fileprivate func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destinationCoordinate = CLLocationCoordinate2D(latitude: 52.518827, longitude: 13.596681)
        let startingLocation = MKPlacemark(coordinate: coordinate)
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        
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
    
    fileprivate func resetMapView(withNew directions: MKDirections) {
        mapView.removeOverlays(mapView.overlays)
        directionsArray.append(directions)
        let _ = directionsArray.map { $0.cancel() }
        directionsArray.removeAll()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if tempBool {
            guard let location = locations.last else { return }
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            getDirections()
            tempBool = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
 
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = #colorLiteral(red: 0.9706280828, green: 0.3376097977, blue: 0.3618901968, alpha: 1)
        renderer.lineWidth = 5.0
        return renderer
    }
    
}
