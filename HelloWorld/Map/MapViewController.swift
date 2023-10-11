//
//  MapViewController.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/10.
//

import Foundation
import MapKit

class MapViewController: BaseViewController {
    
    let mainView = MyMapView()
    
    override func loadView() {
        view.self = mainView
    }
    
    let viewModel = MyMapViewModel()
    let searchCompleter = MKLocalSearchCompleter()
    let geocoder = CLGeocoder()
    
    var completionHandler: ((String, CLLocationDegrees, CLLocationDegrees) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.searchedResults.bind { _ in
            self.mainView.searchTableView.reloadData()
        }
        viewModel.placeName.bind { name in
            let lat = self.viewModel.latitude.value
            let lon = self.viewModel.longitude.value 
            self.addToMap(name: name, lat: lat, lon: lon)
        }
        if viewModel.latitude.value == 0 {
            setfirstView()
        }
        
        setSearchCompleter()
        mainView.searchBar.delegate = self
        mainView.searchTableView.delegate = self
        mainView.searchTableView.dataSource = self
        
        mainView.okButton.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
    }
    
    func setfirstView() {
        
        let center = CLLocationCoordinate2D(latitude: 38, longitude: 127)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000000)
        mainView.mapView.setRegion(region, animated: true)
    }
    
    @objc func okButtonClicked() {
        let name = self.viewModel.placeName.value
        let lat = self.viewModel.latitude.value
        let lon = self.viewModel.longitude.value
        completionHandler?(name, lat, lon)
        
        dismiss(animated: true)
    }
    
    func setSearchCompleter() {
        
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
    }
}

extension MapViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        mainView.searchTableView.isHidden = false
        searchCompleter.queryFragment = searchText
    }
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchedResults.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = viewModel.searchedResults.value[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isHidden = true
        mainView.endEditing(true)
        
        let location = viewModel.searchedResults.value[indexPath.row]
        geocoder.geocodeAddressString(location) { placemarks, error in
            guard let list = placemarks else { return }
            let item = list[0]
            
            guard let lat = item.location?.coordinate.latitude else { return }
            guard let lon = item.location?.coordinate.longitude else { return }
            guard let name = item.name else { return }
            
            self.viewModel.latitude.value = lat
            self.viewModel.longitude.value = lon
            self.viewModel.placeName.value = name
            
        }
    }
    
    func addToMap(name: String, lat: CLLocationDegrees, lon: CLLocationDegrees) {
        
        mainView.mapView.removeAnnotations(mainView.mapView.annotations)
        
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mainView.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        mainView.mapView.addAnnotation(annotation)
        
    }
    
}

extension MapViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        viewModel.searchedResults.value.removeAll()
        
        let searchResult = completer.results
        for item in searchResult {
            viewModel.searchedResults.value.append(item.title)
        }
        
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
