//
//  MapView.swift
//  HelloWorld
//
//  Created by Yeonu Park on 2023/10/10.
//

import UIKit
import MapKit

class MyMapView: BaseView {
    
    let okButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "checkmark"), for: .normal)
        
        return view
    }()
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = NSLocalizedString("myMap_searchBarTitle", comment: "")
        
        return view
    }()
    
    let mapView = {
        let view = MKMapView()
        
        return view
    }()
    
    let searchTableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.backgroundColor = .clear
        view.rowHeight = 50
        
        return view
    }()
    
    override func configure() {
        addSubview(okButton)
        addSubview(searchBar)
        addSubview(mapView)
        addSubview(searchTableView)
    }
    
    override func setConstraints() {
        okButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(50)
        }
        searchBar.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(okButton.snp.leading)
            make.height.equalTo(50)
        }
        mapView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        searchTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
}
