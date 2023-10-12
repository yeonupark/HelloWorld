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
        
        viewModel.myTravelAgendas.bind { _ in
            self.setAnnotations()
        }
        
        setMap()
        mainView.mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.myTravelAgendas.value = locationRepository.fetch()
    }
    
    func setMap() {
        
        setAnnotations()
        
        guard let place = viewModel.myTravelAgendas.value.first else { return }
        let center = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10000000, longitudinalMeters: 10000000)
        mainView.mapView.setRegion(region, animated: true)
    }
    
    func setAnnotations() {
        
        mainView.mapView.removeAnnotations(mainView.mapView.annotations)
        
        let locations = viewModel.myTravelAgendas.value
        
        for table in locations {
            let name = table.placeName
            let lat = table.latitude
            let lon = table.longitude
            
            let annotation = MKPointAnnotation()
            annotation.title = name
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
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
        present(vc, animated: true)
    }
}
