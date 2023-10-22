//
//  WorldMapViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/11.
//

import UIKit
import MapKit

class WorldMapViewController: BaseViewController {
    
    let mainView = WorldMapView()
    override func loadView() {
        view.self = mainView
    }
    
    let viewModel = WorldMapViewModel()
    let locationRepository = LocationTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.myLocations.bind { _ in
            self.setAnnotations()
        }
        
        setMap()
        mainView.mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.myLocations.value = locationRepository.fetch()
    }
    
    func setMap() {
        
        setAnnotations()
        
        guard let place = viewModel.myLocations.value.first else { return }
        let center = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 3000000, longitudinalMeters: 3000000)
        mainView.mapView.setRegion(region, animated: true)
    }
    
    func setAnnotations() {
        
        mainView.mapView.removeAnnotations(mainView.mapView.annotations)
        
        let locations = viewModel.myLocations.value
        
        for table in locations {
            let name = table.placeName
            let lat = table.latitude
            let lon = table.longitude
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            annotation.title = name
            mainView.mapView.addAnnotation(annotation)
        }
    }
}

extension WorldMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        let vc = WeatherViewController()
        if let title = annotation.title {
            vc.viewModel.placeName = title ?? ""
        }
        vc.viewModel.latitude = annotation.coordinate.latitude
        vc.viewModel.longitude = annotation.coordinate.longitude
        
        present(vc, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           
           let reuseIdentifier = "customAnnotationView"
           var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
           
           if annotationView == nil {
               annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
               
           } else {
               annotationView?.annotation = annotation
           }
           
           annotationView?.image = UIImage(named: "MandarinMarker")
           annotationView?.frame.size = CGSize(width: 50, height: 50)
           return annotationView
       }
}

