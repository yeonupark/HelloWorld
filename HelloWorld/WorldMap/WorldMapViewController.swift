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
            self.setMap()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.myTravelAgendas.value = locationRepository.fetch()
    }
    
    func setMap() {
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
        
        guard let place = viewModel.myTravelAgendas.value.first else { return }
        let center = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 10000000, longitudinalMeters: 10000000)
        mainView.mapView.setRegion(region, animated: true)
    }
}
